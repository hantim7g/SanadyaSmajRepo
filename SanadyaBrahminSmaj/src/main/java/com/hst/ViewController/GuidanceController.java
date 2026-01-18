package com.hst.ViewController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hst.entity.Guidance;
import com.hst.repository.GuidanceRepository;

@Controller
public class GuidanceController {

	@Value("${upload.image.dir}")
	private String uploadDirPath;
    @Autowired
    private GuidanceRepository repo;

    @GetMapping("/smajHistory")
    public String smajHistory() {
       
        return "samaj-itihas";
    }
    @GetMapping("/smajUddeshLakshya")
    public String smajUddeshLakshya() {
       
        return "samaj-uddesh-lakshya";
    }
    
   
    
    
    /* PUBLIC VIEW */
    @GetMapping("/guidance")
    public String viewGuidance(Model model, Principal principal) {

        model.addAttribute("guidanceList", repo.findAllByOrderByPriorityAsc());

        boolean isAdmin = principal != null &&
                SecurityContextHolder.getContext().getAuthentication()
                        .getAuthorities().stream()
                        .anyMatch(a -> a.getAuthority().equals("ADMIN"));

        model.addAttribute("isAdmin", isAdmin);
        return "guidance/guidance-list";
    }

    /* ADD FORM */
    @GetMapping("/admin/guidance/add")
    public String addForm(Model model) {
        model.addAttribute("guidance", new Guidance());
        model.addAttribute("actionUrl", "/admin/guidance/save");
        return "guidance/guidance-form";
    }

    /* EDIT FORM */
    @GetMapping("/admin/guidance/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        model.addAttribute("guidance", repo.findById(id).orElseThrow());
        model.addAttribute("actionUrl", "/admin/guidance/save");
        return "guidance/guidance-form";
    }

    /* SAVE */
    @PostMapping("/admin/guidance/save")
    public String saveGuidance(
            @ModelAttribute Guidance guidance,
            @RequestParam("imageFile") MultipartFile imageFile) throws IOException {

        // 🔹 Fetch existing record (for edit case)
        Guidance existing = null;

        if (guidance.getId() != null) {
            existing = repo.findById(guidance.getId()).orElse(null);
        }

        // 🔹 Image uploaded → replace
        if (imageFile != null && !imageFile.isEmpty()) {

            String uploadDir = uploadDirPath + "/guidance/";
            Files.createDirectories(Paths.get(uploadDir));

            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path filePath = Paths.get(uploadDir, fileName);

            Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            guidance.setImageUrl("/images/guidance/" + fileName);

            // OPTIONAL: delete old image
            if (existing != null && existing.getImageUrl() != null) {
                deleteOldFile(existing.getImageUrl());
            }

        } else {
            // 🔹 No new image → keep old image
            if (existing != null) {
                guidance.setImageUrl(existing.getImageUrl());
            }
        }

        repo.save(guidance);
        return "redirect:/guidance";
    }
    private void deleteOldFile(String imageUrl) {
        try {
            String filePath = uploadDirPath + imageUrl.replace("/uploads/guidance/", "");
            Files.deleteIfExists(Paths.get(filePath));
        } catch (Exception e) {
            // log only, don't break save
        }
    }


    /* DELETE */
    @DeleteMapping("/admin/guidance/delete/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        repo.deleteById(id);
    }
}
