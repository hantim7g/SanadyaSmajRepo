package com.hst.util;

import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.http.ResponseEntity;

import java.util.Map;

//@RestControllerAdvice
public class FileUploadExceptionAdvice {

  //  @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<?> handleMaxSizeException(MaxUploadSizeExceededException exc) {
        return ResponseEntity.badRequest().body(Map.of(
            "message", "⚠️ फ़ाइल आकार सीमा पार कर गया (अधिकतम 5MB अनुमति है)"
        ));
    }
}
