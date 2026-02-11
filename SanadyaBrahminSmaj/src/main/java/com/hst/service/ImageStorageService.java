package com.hst.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.io.IOException;
import java.nio.file.*;
import java.time.Instant;
import java.util.Locale;

@Service
public class ImageStorageService {

    private final Path uploadRoot;
@Autowired
	private CloudinaryService cloudinaryService;
    public ImageStorageService(@Value("${upload.image.dir}") String uploadDir) {
        this.uploadRoot = Paths.get(uploadDir).toAbsolutePath().normalize();
    }

    public String storeImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        String ct = file.getContentType();
        if (ct == null || !(ct.equalsIgnoreCase("image/png")
                || ct.equalsIgnoreCase("image/jpeg")
                || ct.equalsIgnoreCase("image/jpg")
                || ct.equalsIgnoreCase("image/webp"))) {
            throw new IOException("Only PNG/JPEG/WEBP images are allowed");
        }

        String imageUrl = cloudinaryService.uploadFile(file, "images");
//        Files.createDirectories(uploadRoot);
//
//        String original = file.getOriginalFilename();
//        String clean = sanitizeFilename(original);
//
//        String ext = getExtension(clean);
//        if (ext.isEmpty()) {
//            ext = mimeToExt(ct);
//        }
//
//        String unique = Instant.now().toEpochMilli() + "-" + clean;
//        if (!ext.isEmpty() && !unique.toLowerCase(Locale.ROOT).endsWith("." + ext)) {
//            unique = unique + "." + ext;
//        }
//
//        Path target = uploadRoot.resolve(unique).normalize();
//        if (!target.startsWith(uploadRoot)) {
//            throw new IOException("Invalid path");
//        }
//
//        try (InputStream in = file.getInputStream()) {
//            Files.copy(in, target, StandardCopyOption.REPLACE_EXISTING);
//        }

//        return "/images/" + target.getFileName().toString();
        return imageUrl;
    }

    private String sanitizeFilename(String name) {
        if (name == null) return "image";
        String cleaned = name.replace("\\", "/");
        cleaned = Paths.get(cleaned).getFileName().toString();
        cleaned = cleaned.replaceAll("[^a-zA-Z0-9._-]", "_");
        if (cleaned.length() > 100) cleaned = cleaned.substring(cleaned.length() - 100);
        if (cleaned.startsWith(".")) cleaned = "img" + cleaned;
        return cleaned.isBlank() ? "image" : cleaned;
    }

    private String getExtension(String name) {
        int idx = name.lastIndexOf('.');
        return (idx > 0 && idx < name.length() - 1)
                ? name.substring(idx + 1).toLowerCase(Locale.ROOT)
                : "";
    }

    private String mimeToExt(String mime) {
        if (mime == null) return "";
        switch (mime.toLowerCase(Locale.ROOT)) {
            case "image/png": return "png";
            case "image/jpeg":
            case "image/jpg": return "jpg";
            case "image/webp": return "webp";
            default: return "";
        }
    }
}
