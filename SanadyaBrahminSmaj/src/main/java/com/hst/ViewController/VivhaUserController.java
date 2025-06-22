package com.hst.ViewController;

import com.hst.entity.VivhaUser;
import com.hst.repository.VivhaUserRepository;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.UUID;

@Controller
public class VivhaUserController {


    public VivhaUserController(VivhaUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Value("${upload.image.dir}")
    private String uploadDir;
    private final VivhaUserRepository userRepository;

    @GetMapping("/vivhauser/form")
    public String showForm(@RequestParam(required = false) Long id, Model model) {
        VivhaUser user = (id != null) ? userRepository.findById(id).orElse(new VivhaUser()) : new VivhaUser();
        model.addAttribute("vivhauser", user);
        return "vivha-form"; // your JSP
    }

    @PostMapping("/vivhauser/save")
    public String saveUser(@ModelAttribute VivhaUser user,
                           @RequestParam(value = "image", required = false) MultipartFile imageFile,
                           RedirectAttributes redirect,
                           HttpServletRequest request) throws IOException {

        // ✅ Handle Image Upload
        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = UUID.randomUUID() + "_" + imageFile.getOriginalFilename();
            String uploadPath = Paths.get(uploadDir).toAbsolutePath().toString();

            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File savedFile = new File(dir, fileName);
            imageFile.transferTo(savedFile);

            // ✅ Save relative image path in DB
            user.setProfileImagePath("/images/" + fileName);
        } else {
            // ✅ If updating, retain previous image path
            if (user.getId() != null) {
                Optional<VivhaUser> existing = userRepository.findById(user.getId());
                existing.ifPresent(existingUser -> user.setProfileImagePath(existingUser.getProfileImagePath()));
            }
        }

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

        // ✅ Load Unicode-supported Hindi font
        String fontPath = new ClassPathResource("fonts/Mangal.TTF").getFile().getAbsolutePath();
        BaseFont baseFont = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font hindiFont = new Font(baseFont, 12, Font.NORMAL);

        // ✅ Now write Hindi content
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

        document.close();
    }
    @GetMapping("/matrimony/my-profiles")
    public String getUserProfiles(Model model, org.springframework.security.core.Authentication authentication) {
        String mobile = authentication.getName(); // Assuming mobile number is in JWT subject

      //  List<VivhaUser> profiles = vivhaUserService.getProfilesByMobile(mobile);
//        model.addAttribute("profiles", profiles);
        return "matrimony/my-profiles";
    }

}
