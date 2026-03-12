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

        val process = ProcessBuilder(
            "audiveris",
            "-batch",
            "-export",
            "-output", "/tmp/output",
            tempFile.absolutePath
        )
            .redirectErrorStream(true)
            .start()

        process.waitFor()

        val outputFile = File("/tmp/output/${tempFile.nameWithoutExtension}.mxl")

        return if (outputFile.exists()) {
            ResponseEntity.ok(outputFile.readText())
        } else {
            ResponseEntity.status(500).body("Audiveris processing failed")
        }
    }
}