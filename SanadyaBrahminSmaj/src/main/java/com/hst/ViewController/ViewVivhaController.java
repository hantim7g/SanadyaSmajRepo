package com.hst.ViewController;
import org.springframework.data.domain.Sort;
import com.hst.entity.User;
import com.hst.entity.VivhaUser;
import com.hst.repository.GotraMasterRepository;
import com.hst.repository.VivhaUserRepository;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

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
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
@Controller
public class ViewVivhaController {

    private final VivhaUserRepository userRepository;
    private final com.hst.repository.GotraMasterRepository gotraMasterRepository;
    public ViewVivhaController(VivhaUserRepository userRepository,GotraMasterRepository gotraMasterRepository) {
        this.userRepository = userRepository;
        this.gotraMasterRepository = gotraMasterRepository;
    }

    @Value("${upload.image.dir}")
    private String uploadDir;

    @GetMapping("/vivhauser/form")
    public String showForm(@RequestParam(required = false) Long id, Model model, Principal principal) {
    	
    	   VivhaUser user = (id != null)
    		        ? userRepository.findById(id).orElse(new VivhaUser())
    		        : new VivhaUser();
    	   boolean isAdmin = principal != null &&
                   SecurityContextHolder.getContext().getAuthentication()
                           .getAuthorities().stream()
                           .anyMatch(a -> a.getAuthority().equals("ADMIN"));
          
    	   model.addAttribute("isAdmin", isAdmin);
    		    model.addAttribute("vivhauser", user);
    		    model.addAttribute("gotraList",
    		        gotraMasterRepository.findByActiveTrueOrderByGotraNameAsc());
        return "vivah/vivha-form";
    }
    
    

    @PostMapping("/vivhauser/save")
    public String saveUser(@ModelAttribute VivhaUser user,
                           @RequestParam(value = "image", required = false) MultipartFile imageFile,
                           RedirectAttributes redirect,
                           Authentication authentication) throws Exception {

        String loggedInMobile = authentication.getName();

        if (user.getId() != null) {
            Optional<VivhaUser> existing = userRepository.findById(user.getId());
            if (existing.isPresent()) {
                VivhaUser existingUser = existing.get();
                if (!loggedInMobile.equals(existingUser.getLoginMobile())) {
                    redirect.addFlashAttribute("error", "आप इस प्रोफ़ाइल को अपडेट करने के लिए अधिकृत नहीं हैं।");
                    return "redirect:/vivhauser/form?id=" + user.getId();
                }

                if ((imageFile == null || imageFile.isEmpty()) && existingUser.getProfileImagePath() != null) {
                    user.setProfileImagePath(existingUser.getProfileImagePath());
                }
            } else {
                redirect.addFlashAttribute("error", "प्रोफ़ाइल नहीं मिली।");
                return "redirect:/vivhauser/form";
            }
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = UUID.randomUUID() + "_" + imageFile.getOriginalFilename();
            String uploadPath = Paths.get(uploadDir).toAbsolutePath().toString();
            File dir = new File(uploadPath);
            if (!dir.exists()) dir.mkdirs();
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
        return "redirect:/vivhauser/form?id=" + user.getId();
    }

    @GetMapping("/vivhauser/pdf/{id}")
    public void downloadHindiPdf(@PathVariable Long id, HttpServletResponse response) throws Exception {
        VivhaUser user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=vivhauser_" + id + ".pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        String fontPath = new ClassPathResource("fonts/Mangal.TTF").getFile().getAbsolutePath();
        BaseFont baseFont = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font hindiFont = new Font(baseFont, 12, Font.NORMAL);

        document.add(new Paragraph("विवाह योग्य युवक/युवती की जानकारी", hindiFont));
        document.add(new Paragraph("पूरा नाम: " + user.getName(), hindiFont));
        document.add(new Paragraph("लिंग: " + user.getGender(), hindiFont));
        document.add(new Paragraph("जन्म तिथि: " + user.getDob(), hindiFont));
        document.add(new Paragraph("मोबाइल: " + user.getMobile(), hindiFont));
        document.add(new Paragraph("ईमेल: " + user.getEmail(), hindiFont));
        document.add(new Paragraph("शिक्षा: " + user.getQualification(), hindiFont));
        document.add(new Paragraph("पेशा: " + user.getOccupation(), hindiFont));
        document.add(new Paragraph("आय: " + user.getIncome(), hindiFont));
        document.add(new Paragraph("पिता का नाम: " + user.getFatherName(), hindiFont));
        document.add(new Paragraph("गोत्र: " + user.getGotra(), hindiFont));
        document.add(new Paragraph("स्थायी पता: " + user.getPermanentAddress(), hindiFont));
        document.add(new Paragraph("माता का नाम: " + user.getMotherName(), hindiFont));
        document.add(new Paragraph("माता का गोत्र: " + user.getMotherGotra(), hindiFont));

        document.add(new Paragraph("दादी का नाम: " + user.getDadiName(), hindiFont));
        document.add(new Paragraph("दादी का गोत्र: " + user.getDadiGotra(), hindiFont));

        document.add(new Paragraph("नानी का नाम: " + user.getNaniName(), hindiFont));
        document.add(new Paragraph("नानी का गोत्र: " + user.getNaniGotra(), hindiFont));

        document.add(new Paragraph("स्वयं का गोत्र: " + user.getGotra(), hindiFont));

        document.close();
    }

    @GetMapping("/matrimony/my-profiles")
    public String getUserProfiles(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/home";
        }

        String mobile = authentication.getName();
        List<VivhaUser> profiles = userRepository.findByMobile(mobile);
        model.addAttribute("profiles", profiles);

        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));
        model.addAttribute("isAdmin", isAdmin);

        return "matrimony/my-profiles";
    }
    @GetMapping({"/matrimony/list", "/matrimony/search"})
    public String listMatrimonyProfiles(
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String manglik,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String gotra,
            @RequestParam(required = false) String qualification,
            @RequestParam(required = false) String occupation,
            @RequestParam(required = false) String income,

            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size,

            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());

        Page<VivhaUser> profilePage =
        		userRepository.searchWithPagination(
                    emptyToNull(gender),
                    emptyToNull(manglik),
                    emptyToNull(city),
                    emptyToNull(district),
                    emptyToNull(gotra),
                    emptyToNull(qualification),
                    emptyToNull(occupation),
                    emptyToNull(income),
                    pageable
                );

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
    private String resolveGotra(String selected, String custom){
        return "OTHER".equals(selected) ? custom : selected;
    }

}
