package com.example.unitybeat.server

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.multipart.MultipartFile
import java.io.File

@RestController
class ImageController {

    @PostMapping("/process")
    fun processImage(@RequestParam("file") file: MultipartFile): ResponseEntity<String> {

        val tempFile = File(System.getProperty("java.io.tmpdir"), file.originalFilename ?: "image.png")
        file.transferTo(tempFile)

        return ResponseEntity.ok("Image received: ${tempFile.absolutePath}")

    }
}