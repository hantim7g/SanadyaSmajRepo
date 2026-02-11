package com.hst.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.hst.service.CloudinaryService;

import java.io.IOException;
import java.nio.file.*;
import java.util.Map;
import java.util.UUID;

@Controller
public class ImageUploadController {

    @Value("${upload.image.dir}")
    private String uploadDir; // example: C:/data/uploads/images

    @Autowired
    private CloudinaryService cloudinaryService;
    @PostMapping("/api/upload-image")
    @ResponseBody
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile image) {
        try {
//            String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
//            Path savePath = Paths.get(uploadDir, fileName);
//
//            Files.createDirectories(savePath.getParent());
//            Files.write(savePath, image.getBytes());
//
//            String imageUrl = "/images/" + fileName;
            String imageUrl = cloudinaryService.uploadFile(image, "images");
            return ResponseEntity.ok(Map.of("imagePath", imageUrl));
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("Error uploading image");
        }
    }
}
