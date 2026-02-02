package com.hst.ViewController.Rooms;

import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import com.hst.entity.BookingSys.*;
import com.hst.repository.BookingGuestRepository;
import com.hst.repository.BookingRepository;
import com.hst.repository.RoomRepository;
import com.hst.util.InvoiceXmlBuilder;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.lowagie.text.Element;
import com.lowagie.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

//===== Java Core =====
import java.io.File;
import java.io.OutputStream;
import java.io.StringReader;
import java.math.BigDecimal;
import java.util.List;

//===== Servlet =====
import jakarta.servlet.http.HttpServletResponse;

//===== Spring MVC =====
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

//===== XML / XSLT =====
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

//===== Apache FOP =====
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

//===== Your Project Entities =====
import com.hst.entity.BookingSys.Booking;
import com.hst.entity.BookingSys.BookingGuest;

//===== Repositories =====
import com.hst.repository.BookingRepository;
import com.hst.repository.BookingGuestRepository;

@Controller
@RequestMapping("/bookings")
public class BookingController {
	@Value("${upload.image.dir}")
	private String uploadDir;
    @Autowired
    private BookingRepository bookingRepo;

    @Autowired
    private BookingGuestRepository guestRepo;

    @Autowired
    private RoomRepository roomRepo;

    /* =========================================================
       ADD BOOKING (FROM ROOM CARD)
       ========================================================= */
    @PostMapping("/add")
    public String addBooking(
            @RequestParam Long roomId,
            @RequestParam
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate checkInDate,
            @RequestParam
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate checkOutDate,
            Model model) {

        if (checkOutDate.isBefore(checkInDate)
                || checkOutDate.isEqual(checkInDate)) {
            throw new IllegalArgumentException("चेक-आउट तिथि अमान्य है");
        }

        Room room = roomRepo.findById(roomId).orElseThrow();

        Booking booking = new Booking();
        booking.setRoom(room);
        booking.setCheckInDate(checkInDate);
        booking.setCheckOutDate(checkOutDate);

        model.addAttribute("booking", booking);
        return "rooms/booking-add";
    }

    /* =========================================================
       SAVE BOOKING
       ========================================================= */
    @PostMapping("/save")
    public String saveBooking(
            @Valid Booking booking,
            BindingResult result,
            @RequestParam("idProofFile") MultipartFile idProofFile,
            @RequestParam(required = false) String[] guestNames,
            @RequestParam(required = false) Integer[] guestAges,
            @RequestParam(required = false) String[] guestGenders,
            Principal principal,
            Model model) throws Exception {

        /* ===== FORM VALIDATION ===== */
        if (booking.getCheckOutDate().isBefore(booking.getCheckInDate())
                || booking.getCheckOutDate().isEqual(booking.getCheckInDate())) {
            result.rejectValue("checkOutDate", "", "चेक-आउट तिथि अमान्य है");
        }

        if (result.hasErrors()) {
            return "rooms/booking-add";
        }

        if (idProofFile == null || idProofFile.isEmpty()) {
            result.rejectValue("idProofFileUrl", "", "ID प्रूफ फ़ाइल अनिवार्य है");
            return "rooms/booking-add";
        }

        /* ===== FILE UPLOAD ===== */
//        String uploadDir = "uploads/id-proof/";
        File dir = new File(uploadDir+"/id-proof/");
        if (!dir.exists()) dir.mkdirs();

        String fileName = System.currentTimeMillis() + "_" + idProofFile.getOriginalFilename();
        File dest = new File(uploadDir+"/id-proof/" + fileName);
        idProofFile.transferTo(dest);
        booking.setIdProofFileUrl(fileName);

        /* ===== PRICE CALCULATION ===== */
        long nights = ChronoUnit.DAYS.between(
                booking.getCheckInDate(),
                booking.getCheckOutDate());

        Room room = roomRepo.findById(booking.getRoom().getId()).orElseThrow();
        booking.setRoom(room);

        BigDecimal total = room.getBasePrice()
                .multiply(BigDecimal.valueOf(nights));

        booking.setRoomPrice(room.getBasePrice());
        booking.setTotalAmount(total);
        booking.setPaidAmount(BigDecimal.ZERO);
        booking.setBalanceAmount(total);

        booking.setStatus(BookingStatus.CONFIRMED);
        booking.setLoginUserMobile(principal != null ? principal.getName() : "SYSTEM");
        booking.setBookingCode(generateBookingCode());

        bookingRepo.save(booking);

        /* ===== EXTRA GUESTS ===== */
        if (guestNames != null) {
            for (int i = 0; i < guestNames.length; i++) {
                if (guestNames[i] == null || guestNames[i].isBlank()) continue;

                BookingGuest g = new BookingGuest();
                g.setBooking(booking);
                g.setName(guestNames[i]);
                g.setAge(guestAges != null && guestAges.length > i ? guestAges[i] : null);
                g.setGender(guestGenders != null && guestGenders.length > i ? guestGenders[i] : null);
                guestRepo.save(g);
            }
        }

        return "redirect:/bookings/admin";
    }


    /* =========================================================
       ADMIN LIST + FILTER
       ========================================================= */
    @GetMapping("/admin")
    public String adminList(
            @RequestParam(required = false) String bookingCode,
            @RequestParam(required = false) String guestName,
            @RequestParam(required = false) BookingStatus status,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate fromDate,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate toDate,
            Model model) {

        List<Booking> bookings =
                bookingRepo.filterBookings(
                        bookingCode, guestName, status, fromDate, toDate);

        model.addAttribute("bookings", bookings);
        model.addAttribute("statuses", BookingStatus.values());

        return "rooms/booking-list";
    }

    /* =========================================================
       VIEW BOOKING
       ========================================================= */
    @GetMapping("/admin/view/{id}")
    public String viewBooking(@PathVariable Long id, Model model) {

        Booking booking = bookingRepo.findById(id).orElseThrow();
        List<BookingGuest> guests =
                guestRepo.findByBookingId(id);

        model.addAttribute("booking", booking);
        model.addAttribute("guests", guests);

        return "rooms/booking-view";
    }

    /* =========================================================
       CONFIRM BOOKING
       ========================================================= */
    @GetMapping("/admin/confirm/{id}")
    public String confirmBooking(@PathVariable Long id) {

        Booking b = bookingRepo.findById(id).orElseThrow();

        if (b.getStatus() == BookingStatus.PENDING) {
            b.setStatus(BookingStatus.CONFIRMED);
            bookingRepo.save(b);
        }

        return "redirect:/bookings/admin";
    }

    /* =========================================================
       CHECK-IN
       ========================================================= */
    @GetMapping("/checkin/{id}")
    public String checkIn(@PathVariable Long id) {

        Booking b = bookingRepo.findById(id).orElseThrow();

        if (b.getStatus() == BookingStatus.CONFIRMED) {
            b.setStatus(BookingStatus.CHECKED_IN);
            b.setActualCheckIn(LocalDateTime.now());
            bookingRepo.save(b);
        }

        return "redirect:/bookings/admin";
    }

    /* =========================================================
       CHECK-OUT
       ========================================================= */
    @GetMapping("/checkout/{id}")
    public String checkOut(@PathVariable Long id) {

        Booking b = bookingRepo.findById(id).orElseThrow();

        if (b.getStatus() == BookingStatus.CHECKED_IN) {
            b.setStatus(BookingStatus.COMPLETED);
            b.setActualCheckOut(LocalDateTime.now());

            Room room = b.getRoom();
            room.setStatus(RoomStatus.AVAILABLE);
            roomRepo.save(room);

            bookingRepo.save(b);
        }

        return "redirect:/bookings/admin";
    }

    /* =========================================================
       CANCEL BOOKING
       ========================================================= */
    @GetMapping("/admin/cancel/{id}")
    public String cancelBooking(@PathVariable Long id) {

        Booking b = bookingRepo.findById(id).orElseThrow();

        if (b.getStatus() != BookingStatus.COMPLETED
                && b.getStatus() != BookingStatus.CANCELLED) {

            b.setStatus(BookingStatus.CANCELLED);

            Room room = b.getRoom();
            room.setStatus(RoomStatus.AVAILABLE);
            roomRepo.save(room);

            bookingRepo.save(b);
        }

        return "redirect:/bookings/admin";
    }

    /* =========================================================
       INVOICE (VIEW / PDF)
       ========================================================= */
    @GetMapping({"/admin/invoice/pdf/{id}" , "/invoice/pdf/{id}"})
    public void generateInvoicePdf(
            @PathVariable Long id,
            HttpServletResponse response) throws Exception {

        Booking booking = bookingRepo.findById(id).orElseThrow();
        List<BookingGuest> guests = guestRepo.findByBookingId(id);

        response.setContentType("application/pdf");
        response.setHeader(
            "Content-Disposition",
            "attachment; filename=Invoice-" + booking.getBookingCode() + ".pdf"
        );

        // ================= FOP SETUP =================
        FopFactory fopFactory = FopFactory.newInstance(
        	    new File("src/main/resources/fop-config.xml")
        	);

//        FopFactory fopFactory = FopFactory.newInstance(
//                new File(".").toURI());
        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

        OutputStream out = response.getOutputStream();
        Fop fop = fopFactory.newFop(
                MimeConstants.MIME_PDF,
                foUserAgent,
                out
        );

        // ================= XML DATA =================
        String xml = InvoiceXmlBuilder.build(booking, guests);

        // ================= XSL TRANSFORM =================
        TransformerFactory factory = TransformerFactory.newInstance();
        Source xsl = new StreamSource(
            getClass().getResourceAsStream("/invoice/invoice.xsl")
        );

        Transformer transformer = factory.newTransformer(xsl);
        Source src = new StreamSource(new StringReader(xml));
        Result res = new SAXResult(fop.getDefaultHandler());

        transformer.transform(src, res);

        out.close();
    }
    private String generateBookingCode() {

        int year = LocalDate.now().getYear();

        long count = bookingRepo.countByYear(year) + 1;

        return String.format("SSB-%d-%04d", year, count);
    }


}
