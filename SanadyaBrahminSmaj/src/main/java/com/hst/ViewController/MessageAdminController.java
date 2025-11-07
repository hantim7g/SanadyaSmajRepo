package com.hst.ViewController;

import com.hst.dto.MessageDto;
import com.hst.entity.Message;
import com.hst.repository.MessageRepository;
import com.hst.service.ImageStorageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/admin/messages")
public class MessageAdminController {

    private final MessageRepository repo;
    private final ImageStorageService imageStorage;

    public MessageAdminController(MessageRepository repo, ImageStorageService imageStorage) {
        this.repo = repo;
        this.imageStorage = imageStorage;
    }

    @GetMapping
    public String list(Model model) {
        List<Message> messages = repo.findAll();
        model.addAttribute("messages", messages);

        // flags for showing buttons (replace with Spring Security if needed)
        model.addAttribute("canCreate", true);
        model.addAttribute("canEdit", true);
        model.addAttribute("canDelete", true);

        return "admin/message-list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("messageDto", new MessageDto());
        return "admin/message-form";
    }

    @PostMapping
    public String create(@ModelAttribute("messageDto") @Valid MessageDto form,
                         BindingResult bindingResult,
                         @RequestParam(name = "photo", required = false) MultipartFile photo,
                         Model model) {

        if (form.getTitle() == null || form.getTitle().isBlank()) {
            bindingResult.rejectValue("title", "title.required", "Title is required");
        }
        if (bindingResult.hasErrors()) {
            return "admin/message-form";
        }

        Message entity = toEntity(form);

        try {
            String photoUrl = imageStorage.storeImage(photo);
            if (photoUrl != null) entity.setPhotoUrl(photoUrl);
        } catch (Exception ex) {
            bindingResult.rejectValue("photoUrl", "upload.failed", "Image upload failed: " + ex.getMessage());
            return "admin/message-form";
        }

        repo.save(entity);
        return "redirect:/admin/messages";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        repo.findById(id).ifPresent(m -> {
            // hard delete
            repo.delete(m);
            // Or soft delete:
            // m.setDeleted(true); repo.save(m);
        });
        return "redirect:/admin/messages";
    }

    private Message toEntity(MessageDto dto) {
        Message e = new Message();
        e.setAuthorName(dto.getAuthorName());
        e.setAuthorTitle(dto.getAuthorTitle());
        e.setAuthorSubtitle(dto.getAuthorSubtitle());
        e.setCityOrArea(dto.getCityOrArea());
        e.setTitle(dto.getTitle());
        e.setLead(dto.getLead());
        e.setContent(dto.getContent());
        e.setContentHtml(dto.getContentHtml());
        e.setQuote(dto.getQuote());
        e.setSignatureName(dto.getSignatureName());
        e.setSignatureDesignation(dto.getSignatureDesignation());
        e.setDateText(dto.getDateText());
        e.setFooterNote(dto.getFooterNote());
        e.setPageNumber(dto.getPageNumber());
        e.setContentFormat(
                dto.getContentHtml() != null && !dto.getContentHtml().isBlank()
                        ? Message.ContentFormat.HTML
                        : Message.ContentFormat.PLAIN
        );
        return e;
    }
}
