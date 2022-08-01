package com.wl.gbl.ge.ssg.render;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hubspot.jinjava.Jinjava;
import com.wl.gbl.ge.ssg.Main;
import com.wl.gbl.ge.ssg.frame.FileInformation;
import com.wl.gbl.ge.ssg.frame.TypeFileEnum;

public class GenerateJinjaFile {
	
	static final Logger logger = LoggerFactory.getLogger(GenerateJinjaFile.class);

	public GenerateJinjaFile() {
	}
	
	public void generateFileJinja(FileInformation dataFile, FileInformation templateFile, String outputFile) {
		String data = null;
		logger.debug("load data file : {}",dataFile);
		if(dataFile!=null) {
			if(TypeFileEnum.CLASSPATH.equals(dataFile.getType())) {
				data = new Scanner(Objects.requireNonNull(GenerateJinjaFile.class.getResourceAsStream(dataFile.getFilePath())), "UTF-8").useDelimiter("\\A").next();
			} else {
				try	{
					data = new String (Files.readAllBytes(Paths.get(dataFile.getFilePath())));
				}
				catch (IOException e) {
					logger.error(e.getMessage(),e);
				}
			}
			
		}
		HashMap<String, Object> mapData = jsonTpMap(data);
		
		
		String template = null;
		logger.debug("load template file : "+templateFile);
		if(dataFile!=null) {
			if(TypeFileEnum.CLASSPATH.equals(templateFile.getType())) {
				template = new Scanner(Objects.requireNonNull(GenerateJinjaFile.class.getResourceAsStream(templateFile.getFilePath())), "UTF-8").useDelimiter("\\A").next();
			} else {
				try	{
					template = new String (Files.readAllBytes(Paths.get(templateFile.getFilePath())));
				}
				catch (IOException e) {
					logger.error(e.getMessage(),e);
				}
			}
			
		}
		
		generateFileJinja(mapData, template, outputFile);
	}
	
	public void generateFileJinjaFromClasspath(String dataFile, String templateFile, String outputFile) {
		// -----------------------------
		// Convert the JSON Data to a Map
		// -----------------------------
		String data =null;
		logger.debug("load data file : "+dataFile);
		data = new Scanner(Objects.requireNonNull(Main.class.getResourceAsStream(dataFile)), "UTF-8").useDelimiter("\\A").next();
		HashMap<String, Object> mapData = jsonTpMap(data);

		String template = null;
		logger.debug("load template file : "+templateFile);
		template = new Scanner(Objects.requireNonNull(Main.class.getResourceAsStream(templateFile)), "UTF-8").useDelimiter("\\A").next();
		generateFileJinja( mapData, template, outputFile);
	}

	public void generateFileJinjaFromLocal(String dataFile, String templateFile, String outputFile) {
		// -----------------------------
		// Convert the JSON Data to a Map
		// -----------------------------
		String data =null;
		logger.debug("load data file : "+dataFile);
		try
		{
			data = new String (Files.readAllBytes(Paths.get(dataFile)));
		}
		catch (IOException e)
		{
			logger.error(e.getMessage(),e);
		}
		HashMap<String, Object> mapData = jsonTpMap(data);

		String template = null;
		logger.debug("load template file : "+templateFile);
		try
		{
			template = new String (Files.readAllBytes(Paths.get(templateFile)));
		}
		catch (IOException e)
		{
			logger.error(e.getMessage(),e);
		}
		generateFileJinja( mapData, template, outputFile);
	}

	private void generateFileJinja(HashMap<String, Object> mapData, String template, String outputFile){
		logger.debug("loading Jinjava ");
		Jinjava jinjava = new Jinjava();
		logger.debug("Jinjava loaded");
		// Final file
		Path finalFile = Paths.get(outputFile);
		try {
			Files.deleteIfExists(finalFile);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
		logger.debug("rendering Template");
		String renderedTemplate = jinjava.render(template, mapData);
		try {
			Files.write(finalFile, renderedTemplate.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE, StandardOpenOption.APPEND);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
	}

	private static HashMap<String, Object> jsonTpMap(String jsonFile){
		HashMap<String, Object> map = new HashMap<String, Object>();

		ObjectMapper mapper = new ObjectMapper();
		try
		{
			//Convert Map to JSON
			map = mapper.readValue(jsonFile, new TypeReference<Map<String, Object>>(){});

			//Print JSON output
			System.out.println(map);
		}
		catch (JsonGenerationException e) {
			logger.error(e.getMessage(),e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(),e);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
		return map;
	}
}
