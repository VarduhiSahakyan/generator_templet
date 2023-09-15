package com.energizeglobal.sqlgenerator.controller;

import com.energizeglobal.sqlgenerator.service.InitialScriptService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static java.nio.charset.StandardCharsets.UTF_8;

@RestController
@RequiredArgsConstructor
@RequestMapping("/initial")
public class InitialScriptController {

    private final InitialScriptService initialScriptService;
    private String SQL_FILE_PATH = "sql-generator" + File.separator + "src" + File.separator + "main" + File.separator + "resources" + File.separator + "sql_scripts" + File.separator;
    private String JSON_FILE_PATH = File.separator + "sql-generator" + File.separator + "target" + File.separator + "classes" + File.separator + "json" + File.separator;

    @PostMapping("/file/json/01/upload")
    public ResponseEntity<String> uploadFileJson01(@RequestParam MultipartFile file){

        String filename = "01_Configuration_IAT.json";
        String projectRootFolder = System.getProperty("user.dir");
        String filePathStr = projectRootFolder + JSON_FILE_PATH + filename;
        Path filePath = Paths.get(filePathStr);
        try {
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                Files.copy(file.getInputStream(), filePath);
            } else {
                String directory = projectRootFolder+JSON_FILE_PATH;
                Path directoryPath = Paths.get(directory);
                Files.createDirectories(directoryPath);
                Files.copy(file.getInputStream(), filePath);
            }
        }
        catch (IOException e){
            throw new RuntimeException("IOException: " + e);
        }
        return ResponseEntity.ok("UPLOADED");
    }

    @PostMapping("/file/sql/01/script")
    public ResponseEntity<String> generateInitialScript01(@RequestBody String sqlMode){

        String sql = initialScriptService.generateInitialScript01(sqlMode);
        writeSQLToFile("01_Configuration_IAT.sql", sql);
        return ResponseEntity.ok(sql);
    }

    @PostMapping("/file/json/02/upload")
    public ResponseEntity<String> uploadFileJson02(@RequestParam MultipartFile file){

        String filename = "02_Profiles.json";
        String projectRootFolder = System.getProperty("user.dir");
        String filePathStr = projectRootFolder + JSON_FILE_PATH + filename;
        Path filePath = Paths.get(filePathStr);
        try {
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                Files.copy(file.getInputStream(), filePath);
            } else {
                String directory = projectRootFolder + JSON_FILE_PATH;
                Path directoryPath = Paths.get(directory);
                Files.createDirectories(directoryPath);
                Files.copy(file.getInputStream(), filePath);
            }
        }
        catch (IOException e){
            throw new RuntimeException("IOException: " + e);
        }
        return ResponseEntity.ok("UPLOADED");
    }

    @PostMapping("/file/sql/02/script")
    public ResponseEntity<String> generateInitialScript02(@RequestBody String sqlMode){

        String sql = initialScriptService.generateInitialScript02(sqlMode);
        String insertRollbackSql = initialScriptService.generateInitialRollbackScript02(sqlMode);
        String selectSql = initialScriptService.generateSelectScript02(sqlMode);
        writeSQLToFile("02_Profiles.sql", sql);
        writeSQLToFile("Rollback_02_Profiles.sql", insertRollbackSql);
        writeSQLToFile("Select_02_Profiles.sql", selectSql);
        return ResponseEntity.ok(sql);
    }

    private void writeSQLToFile(String filename, String sql) {

        String path = SQL_FILE_PATH + filename;
        Path newFilePath = Paths.get(path);
        try {
            if (Files.exists(newFilePath)) {
                Files.delete(newFilePath);
                try (BufferedWriter bufferedWriter = Files.newBufferedWriter(newFilePath, UTF_8)) {
                    bufferedWriter.write(sql);
                }
            } else {
                Path fileDirectory = Paths.get(SQL_FILE_PATH);
                Files.createDirectories(fileDirectory);
                try (BufferedWriter bufferedWriter = Files.newBufferedWriter(newFilePath, UTF_8)) {
                    bufferedWriter.write(sql);
                }
            } 
        } catch (IOException e) {
            throw new RuntimeException("IOException: " + e.getMessage());
        }
    }
}
