package com.hst.ViewController;

import org.springframework.data.domain.Sort;

import com.hst.entity.GotraMaster;
import com.hst.entity.User;
import com.hst.entity.VivhaUser;
import com.hst.repository.GotraMasterRepository;
import com.hst.repository.VivhaUserRepository;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
//Apache FOP
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.MimeConstants;

//XML Transform
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

//Java IO
import java.io.OutputStream;
import java.io.StringReader;
import java.io.File;

//Spring / Servlet
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ViewVivhaController {

	private final VivhaUserRepository userRepository;
	private final com.hst.repository.GotraMasterRepository gotraMasterRepository;

	public ViewVivhaController(VivhaUserRepository userRepository, GotraMasterRepository gotraMasterRepository) {
		this.userRepository = userRepository;
		this.gotraMasterRepository = gotraMasterRepository;
	}

	@Value("${upload.image.dir}")
	private String uploadDir;

	@GetMapping("/user/vivhauser/form")
	public String showForm(@RequestParam(required = false) Long id, Model model, Authentication authentication,
			RedirectAttributes redirect) {

		VivhaUser user;

		if (id != null) {
			user = userRepository.findById(id).orElse(null);

			if (user == null) {
				redirect.addFlashAttribute("error", "प्रोफ़ाइल नहीं मिली।");
				return "redirect:/home";
			}

			if (!canEditProfile(user, authentication)) {
				redirect.addFlashAttribute("error", "आप इस प्रोफ़ाइल को संपादित करने के लिए अधिकृत नहीं हैं।");
				return "redirect:/user/matrimony/list";
			}
		} else {
			user = new VivhaUser();
		}

		boolean isAdmin = authentication != null
				&& authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		model.addAttribute("isAdmin", isAdmin);
		model.addAttribute("vivhauser", user);
		model.addAttribute("gotraList", gotraMasterRepository.findByActiveTrueOrderByGotraNameAsc());

		return "vivah/vivha-form";
	}

	@PostMapping("/user/vivhauser/save")
	public String saveUser(@ModelAttribute VivhaUser user,
			@RequestParam(value = "image", required = false) MultipartFile imageFile, RedirectAttributes redirect,
			Authentication authentication) throws Exception {

		String loggedInMobile = authentication.getName();

		if (user.getId() != null) {
			Optional<VivhaUser> existing = userRepository.findById(user.getId());
			if (existing.isPresent()) {
				VivhaUser existingUser = existing.get();
				boolean isAdmin = authentication.getAuthorities().stream()
						.anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

				if (!isAdmin && !loggedInMobile.equals(existingUser.getLoginMobile())) {
					redirect.addFlashAttribute("error", "आप इस प्रोफ़ाइल को अपडेट करने के लिए अधिकृत नहीं हैं।");
					return "redirect:/user/vivhauser/form?id=" + user.getId();
				}

				if ((imageFile == null || imageFile.isEmpty()) && existingUser.getProfileImagePath() != null) {
					user.setProfileImagePath(existingUser.getProfileImagePath());
				}
			} else {
				redirect.addFlashAttribute("error", "प्रोफ़ाइल नहीं मिली।");
				return "redirect:/user/vivhauser/form";
			}
		}

		if (imageFile != null && !imageFile.isEmpty()) {
			String fileName = UUID.randomUUID() + "_" + imageFile.getOriginalFilename();
			String uploadPath = Paths.get(uploadDir).toAbsolutePath().toString();
			File dir = new File(uploadPath);
			if (!dir.exists())
				dir.mkdirs();
			File savedFile = new File(dir, fileName);
			imageFile.transferTo(savedFile);
			user.setProfileImagePath("/images/" + fileName);
		}

		user.setLoginMobile(loggedInMobile);
		user.setGotra(resolveGotra(user.getGotra(), user.getCustomGotra()));
		user.setMotherGotra(resolveGotra(user.getMotherGotra(), user.getMotherCustomGotra()));
		user.setDadiGotra(resolveGotra(user.getDadiGotra(), user.getDadiCustomGotra()));
		user.setNaniGotra(resolveGotra(user.getNaniGotra(), user.getNaniCustomGotra()));
		userRepository.save(user);
		redirect.addFlashAttribute("success", true);
		return "redirect:/user/vivhauser/form?id=" + user.getId();
	}

//    @GetMapping("/user/vivhauser/pdf/{id}")
//    public void downloadBiodataPdf(
//            @PathVariable Long id,
//            HttpServletResponse response) throws Exception {
//
//    	  VivhaUser p = userRepository.findById(id)
//                  .orElseThrow(() -> new RuntimeException("User not found"));
//
//
//        response.setContentType("application/pdf");
//        response.setHeader(
//                "Content-Disposition",
//                "attachment; filename=biodata_" + p.getName() + ".pdf"
//        );
//
//        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
//        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
//        document.open();
//
//        /* ================= FONT (Hindi Safe) ================= */
//        BaseFont bf = BaseFont.createFont(
//                "fonts/NotoSansDevanagari-Regular.ttf",
//                BaseFont.IDENTITY_H,
//                BaseFont.EMBEDDED
//        );
//
//        Font titleFont  = new Font(bf, 18, Font.BOLD);
//        Font labelFont  = new Font(bf, 11, Font.BOLD);
//        Font valueFont  = new Font(bf, 11);
//        Font smallFont  = new Font(bf, 10);
//        Font footerFont = new Font(bf, 9, Font.ITALIC, BaseColor.DARK_GRAY);
//
//
//        /* ================= CARD BACKGROUND ================= */
//        PdfContentByte canvas = writer.getDirectContentUnder();
//
//        Rectangle card = new Rectangle(
//                document.left() - 10,
//                document.bottom() - 10,
//                document.right() + 10,
//                document.top() + 10
//        );
//
//        card.setBackgroundColor(new BaseColor(255, 248, 235)); // light cream
//        card.setBorder(Rectangle.BOX);
//        card.setBorderWidth(1.5f);
//        card.setBorderColor(new BaseColor(247, 126, 3)); // orange
//
//        canvas.rectangle(card);
//
//        /* ================= HEADER ================= */
//        Paragraph title = new Paragraph(
//                p.getName() + " (" + p.getGender() + ")",
//                titleFont
//        );
//        title.setSpacingBefore(20);
//        title.setSpacingAfter(10);
//        document.add(title);
//
//        LineSeparator separator = new LineSeparator();
//        separator.setLineWidth(1.5f);
//        separator.setLineColor(new BaseColor(247, 126, 3));
//        document.add(separator);
//
//        /* ================= MAIN TABLE ================= */
//        PdfPTable mainTable = new PdfPTable(new float[]{2.5f, 5f, 3f});
//        mainTable.setWidthPercentage(100);
//        mainTable.setSpacingBefore(15);
//
//        /* -------- PHOTO -------- */
//        Image photo;
//
//        try {
//            String imagePath = uploadDir.replaceAll("/images", "")+p.getProfileImagePath(); // e.g. C:\\data\\uploads\\images\\img1.jpg
//
//            if (imagePath != null && new File(imagePath).exists()) {
//                photo = Image.getInstance(imagePath);
//            } else {
//                photo = Image.getInstance(
//                        getClass().getClassLoader()
//                                .getResource("static/images/default-profile.png")
//                );
//            }
//
//        } catch (Exception e) {
//            photo = Image.getInstance(
//                    getClass().getClassLoader()
//                            .getResource("static/images/default-profile.png")
//            );
//        }
//
//
//        photo.scaleAbsolute(110, 130);
//        photo.setAlignment(Image.ALIGN_CENTER);
//
//        PdfPCell photoCell = new PdfPCell(photo);
//        photoCell.setBorder(Rectangle.NO_BORDER);
//        photoCell.setHorizontalAlignment(Element.ALIGN_CENTER);
//        photoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
//        mainTable.addCell(photoCell);
//
//        /* -------- DETAILS (CENTER) -------- */
//        PdfPCell detailCell = new PdfPCell();
//        detailCell.setBorder(Rectangle.NO_BORDER);
//
//        detailCell.addElement(field("जन्म तिथि", p.getDob().toString(), labelFont, valueFont));
//        detailCell.addElement(field("जन्म समय", p.getBirthTime(), labelFont, valueFont));
//        detailCell.addElement(field("पिता", p.getFatherName(), labelFont, valueFont));
//        detailCell.addElement(field("माता", p.getMotherName(), labelFont, valueFont));
//        detailCell.addElement(field("शिक्षा", p.getQualification(), labelFont, valueFont));
//        detailCell.addElement(field("पेशा", p.getOccupation(), labelFont, valueFont));
//        detailCell.addElement(field("आय", p.getIncome(), labelFont, valueFont));
//        detailCell.addElement(field("कद", p.getHeight(), labelFont, valueFont));
//        detailCell.addElement(field("मांगलिक", p.getManglik(), labelFont, valueFont));
//        detailCell.addElement(field("स्थिति", p.getMaritalStatus(), labelFont, valueFont));
//
//        detailCell.addElement(field(
//                "निवास",
//                p.getHouseAddress() + ", " + p.getCity() + ", " + p.getState(),
//                labelFont,
//                valueFont
//        ));
//
//        detailCell.addElement(field("मोबाइल", p.getMobile(), labelFont, valueFont));
//
//        mainTable.addCell(detailCell);
//
//        /* -------- GOTRA BOX (RIGHT) -------- */
//        PdfPCell gotraCell = new PdfPCell();
//        gotraCell.setPadding(10);
//        gotraCell.setBackgroundColor(new BaseColor(255, 235, 210));
//        gotraCell.setBorder(Rectangle.BOX);
//        gotraCell.setBorderColor(new BaseColor(247, 126, 3));
//
//        gotraCell.addElement(new Paragraph("गोत्र विवरण", labelFont));
//        gotraCell.addElement(new Paragraph("• स्वयं: " + p.getGotra(), smallFont));
//        gotraCell.addElement(new Paragraph("• माता: " + p.getMotherGotra(), smallFont));
//        gotraCell.addElement(new Paragraph("• दादी: " + p.getDadiGotra(), smallFont));
//        gotraCell.addElement(new Paragraph("• नानी: " + p.getNaniGotra(), smallFont));
//
//        mainTable.addCell(gotraCell);
//
//        document.add(mainTable);
//
//        /* ================= FOOTER ================= */
//        Paragraph footer = new Paragraph(
//                "Generated by Sanadya Brahmin Sabha, Kota",
//                footerFont
//        );
//        footer.setAlignment(Element.ALIGN_CENTER);
//        footer.setSpacingBefore(40);
//        document.add(footer);
//
//        document.close();
//    }
//
//    /* ================= HELPER METHOD ================= */
//    private Paragraph field(
//            String label,
//            String value,
//            Font labelFont,
//            Font valueFont) {
//
//        Paragraph p = new Paragraph();
//        p.add(new Chunk(label + ": ", labelFont));
//        p.add(new Chunk(
//                value != null && !value.isBlank() ? value : "-",
//                valueFont
//        ));
//        p.setSpacingAfter(4);
//        return p;
//    }
	@GetMapping("/user/vivhauser/pdf/{id}")
	public void downloadPdf(@PathVariable Long id, HttpServletResponse response) throws Exception {
		VivhaUser p = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));

		generateBiodataPdf(p, response);
	}

	public void generateBiodataPdf(VivhaUser p, HttpServletResponse response) throws Exception {

		String template = Files.readString(Paths.get("src/main/resources/templates/biodata.fo"),
				StandardCharsets.UTF_8);
		String imageUri = "";

		if (p.getProfileImagePath() != null && !p.getProfileImagePath().isBlank()) {
		    imageUri = new File(
		            uploadDir.replaceAll("/images", "")
		            + p.getProfileImagePath()
		    ).toURI().toString();
		}
		template = template.replace("${name}", p.getName()).replace("${gender}", p.getGender())
				.replace("${dob}", p.getDob().toString()).replace("${birthTime}", p.getBirthTime())
				.replace("${father}", p.getFatherName()).replace("${mother}", p.getMotherName())
				.replace("${education}", p.getQualification()).replace("${occupation}", p.getOccupation())
				.replace("${income}", p.getIncome()).replace("${height}", p.getHeight())
				.replace("${manglik}", p.getManglik()).replace("${marital}", p.getMaritalStatus())
				.replace("${address}", p.getHouseAddress() + ", " + p.getCity()).replace("${mobile}", p.getMobile())
				.replace("${gotra}", p.getGotra()).replace("${motherGotra}", p.getMotherGotra())
				.replace("${dadiGotra}", p.getDadiGotra()).replace("${naniGotra}", p.getNaniGotra())
				.replace("${photoPath}", imageUri);

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=biodata_" + p.getName() + ".pdf");

		FopFactory fopFactory = FopFactory.newInstance(new File("src/main/resources/fop-config.xml"));

		FOUserAgent userAgent = fopFactory.newFOUserAgent();

		OutputStream out = response.getOutputStream();
		Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, userAgent, out);

		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		Source src = new StreamSource(new StringReader(template));
		Result res = new SAXResult(fop.getDefaultHandler());

		transformer.transform(src, res);
	}

	@GetMapping("/user/matrimony/my-profiles")
	public String getUserProfiles(Model model, Authentication authentication) {
		if (authentication == null || !authentication.isAuthenticated()) {
			return "redirect:/home";
		}

		String mobile = authentication.getName();
		List<VivhaUser> profiles = userRepository.findByLoginMobile(mobile);
		model.addAttribute("profiles", profiles);

		boolean isAdmin = authentication.getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));
		model.addAttribute("isAdmin", isAdmin);

		return "vivah/matrimony-list-user";
	}

	@GetMapping({ "/user/matrimony/list", "/user/matrimony/search" })
	public String listMatrimonyProfiles(@RequestParam(required = false) String gender,
			@RequestParam(required = false) String manglik, @RequestParam(required = false) String city,
			@RequestParam(required = false) String district, @RequestParam(required = false) String gotra,
			@RequestParam(required = false) String qualification, @RequestParam(required = false) String occupation,
			@RequestParam(required = false) String income, @RequestParam(required = false) List<String> excludeGotras,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "20") int size,

			Model model) {

		Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());

		List<GotraMaster> gotraList = gotraMasterRepository.findByActiveTrueOrderByGotraNameAsc();
		if (excludeGotras != null && excludeGotras.isEmpty()) {
			excludeGotras = null;
		}

		model.addAttribute("gotraList", gotraList);
		Page<VivhaUser> profilePage = userRepository.searchWithPagination(excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
//        				excludeGotras,
				emptyToNull(gender), emptyToNull(manglik), emptyToNull(city), emptyToNull(district),
				emptyToNull(qualification), emptyToNull(occupation), emptyToNull(income), pageable);

		model.addAttribute("profiles", profilePage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", profilePage.getTotalPages());
		model.addAttribute("totalItems", profilePage.getTotalElements());

		// keep filters for pagination links
		model.addAttribute("gender", gender);
		model.addAttribute("manglik", manglik);
		model.addAttribute("city", city);
		model.addAttribute("district", district);
		model.addAttribute("gotra", gotra);
		model.addAttribute("qualification", qualification);
		model.addAttribute("occupation", occupation);
		model.addAttribute("income", income);

		return "vivah/matrimony-list";
	}

	private String emptyToNull(String value) {
		return (value == null || value.trim().isEmpty()) ? null : value;
	}

	private String resolveGotra(String selected, String custom) {
		return "OTHER".equals(selected) ? custom : selected;
	}

	private boolean canEditProfile(VivhaUser user, Authentication auth) {
		if (auth == null || !auth.isAuthenticated()) {
			return false;
		}

		// ADMIN can edit all
		boolean isAdmin = auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		if (isAdmin) {
			return true;
		}

		// Owner can edit
		return auth.getName().equals(user.getLoginMobile());
	}

	@GetMapping("/admin/matrimony/list")
	public String listMatrimonyProfilesAdmin(@RequestParam(required = false) String gender,
			@RequestParam(required = false) String manglik, @RequestParam(required = false) String city,
			@RequestParam(required = false) String district, @RequestParam(required = false) String gotra,
			@RequestParam(required = false) String qualification, @RequestParam(required = false) String occupation,
			@RequestParam(required = false) String income, @RequestParam(required = false) List<String> excludeGotras,

			// ✅ NEW (Admin only)
			@RequestParam(required = false) Boolean approved, @RequestParam(required = false) Boolean active,

			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "20") int size, Model model) {

		Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());

		List<GotraMaster> gotraList = gotraMasterRepository.findByActiveTrueOrderByGotraNameAsc();

		if (excludeGotras != null && excludeGotras.isEmpty()) {
			excludeGotras = null;
		}

		Page<VivhaUser> profilePage = userRepository.searchWithPaginationAdmin(excludeGotras, emptyToNull(gender),
				emptyToNull(manglik), emptyToNull(city), emptyToNull(district), emptyToNull(qualification),
				emptyToNull(occupation), emptyToNull(income), approved, active, pageable);

		model.addAttribute("gotraList", gotraList);
		model.addAttribute("profiles", profilePage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", profilePage.getTotalPages());
		model.addAttribute("totalItems", profilePage.getTotalElements());

		// keep filters
		model.addAttribute("gender", gender);
		model.addAttribute("manglik", manglik);
		model.addAttribute("city", city);
		model.addAttribute("district", district);
		model.addAttribute("qualification", qualification);
		model.addAttribute("occupation", occupation);
		model.addAttribute("income", income);
		model.addAttribute("approved", approved);
		model.addAttribute("active", active);

		return "vivah/matrimony-list-admin";
	}

	@PostMapping("/admin/matrimony/{id}/approve")
	@ResponseBody
	public String approveProfile(@PathVariable Long id, @RequestParam boolean approved, Authentication authentication) {

		if (authentication == null
				|| authentication.getAuthorities().stream().noneMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
			return "UNAUTHORIZED";
		}

		userRepository.updateApproved(id, approved);
		return "OK";
	}

	@PostMapping("/admin/matrimony/{id}/active")
	@ResponseBody
	public String activeProfile(@PathVariable Long id, @RequestParam boolean active, Authentication authentication) {

		if (authentication == null
				|| authentication.getAuthorities().stream().noneMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
			return "UNAUTHORIZED";
		}

		userRepository.updateActive(id, active);
		return "OK";
	}

}
