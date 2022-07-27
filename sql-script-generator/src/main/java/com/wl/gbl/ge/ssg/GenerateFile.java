package com.wl.gbl.ge.ssg;

import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hubspot.jinjava.Jinjava;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.wl.gbl.ge.ssg.utils.HeaderManager;

public class GenerateFile {
	
	static final Logger logger = LoggerFactory.getLogger(GenerateFile.class);

	public static final String LINESEPARATOR = "\n";
	/* Key to start at value 1 */
	private static final String START_1 = "###START_1###";
	private static final int START_1_VALUE = 1;
	/* Key to start at value 1 */
	private static final String START_2 = "###START_2###";
	private static final int START_2_VALUE = 2;
	/* Key to add the current value */
	private static final String CURRENT_VALUE = "###VALUE###";
	private final static Pattern patternKeyForOptionalLine = Pattern.compile("^\\[\\[(.*?)\\]\\]");
	private final static Pattern patternKey = Pattern.compile("\\$\\{(.*?)\\}");

	public GenerateFile() {
	}
	
	public void generateFile(String propertiesFile, String templateFile, String outputFile) {
		// Load properties
		URL urlProperties = Main.class.getResource(propertiesFile);
		Properties prop = new Properties();
		try (InputStream input = urlProperties.openStream()) {
			// load a properties file
			prop.load(input);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}

		// Load template
		URL urlTemplate = Main.class.getResource(templateFile);
		
		// Final file
		Path finalFile = Paths.get(outputFile);
		try {
			Files.deleteIfExists(finalFile);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
		
		try {
			HeaderManager.addHeader(finalFile, propertiesFile, templateFile);
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
		
		try {
			Scanner scanner = new Scanner(urlTemplate.openStream());
			
			//renvoie true s'il y a une autre ligne à lire
			while(scanner.hasNextLine()){
				String line = scanner.nextLine();
				logger.trace(line);
	    	  
				// Clean up the temporary template
				//We delete the lines that will not be used
				//- We go through all the lines
				//- We are looking for lines that start with [[key]]
				//- If we find key in the properties, we leave the line
				//- If key is not present, the line is deleted
				
				Matcher matcherForOptionalLine = patternKeyForOptionalLine.matcher(line); 
				
				if(matcherForOptionalLine.find()){
					String completeKey = matcherForOptionalLine.group(0); // key with [[ ]]
					String key = matcherForOptionalLine.group(1); // key without [[ ]]
					logger.debug("Key found! "+matcherForOptionalLine.group(1));
					
					// we have a multiple key
					if(key!=null && (key.contains(START_1) || key.contains(START_2))) {
						
						String newLines = "";
						int nb = 0;
						if(key.contains(START_1)) {
							nb = START_1_VALUE;
						} else {
							nb = START_2_VALUE;
						}
						
						boolean lastKeyFound = true;
						
						while(lastKeyFound) {
							String customKey = key.replace(START_1, String.valueOf(nb));
							customKey = customKey.replace(START_2, String.valueOf(nb));
							logger.debug("New key: "+customKey);
							
							String newLine = line;
							if(prop.containsKey(customKey)){
								logger.debug("New key found!");
								// We add the line
								newLine = newLine.replace(completeKey, "");
								newLine = newLine.replace(CURRENT_VALUE, String.valueOf(nb));
								
								if(!"".equals(newLines)) {
									newLines = newLines + LINESEPARATOR;
								}
								newLines = newLines + newLine;
								
							} else {
								lastKeyFound = false;
							}
							nb++;
						}
						
						line = newLines;
						logger.debug("New lines:"+line);
					}
					// we have a key that does not exist in the properties file
					else if(!prop.containsKey(key)) {
						logger.debug("We delete the line:"+line);
						continue;
					} else {
						line = line.replace(completeKey, "");
					}
				}

				line = replacePropertiesForALine(prop, line);
				
				String lineWithLineSeparator = line + LINESEPARATOR;
				
				byte data[] = lineWithLineSeparator.getBytes(Charset.forName("UTF-8"));
				Files.write(finalFile, data, StandardOpenOption.CREATE, StandardOpenOption.APPEND);

			}
			scanner.close();    
		} catch(IOException e) {
			logger.error(e.getMessage(),e);
		}
	}
	
	private String replacePropertiesForALine(Properties prop, String line) {
		// The line is saved by replacing the keys present if necessary
		
		Matcher matcherKey = patternKey.matcher(line);
		while(matcherKey.find()) {
			String completeKey = matcherKey.group(0); // key with ${ }
			String key = matcherKey.group(1); // key without ${ }
			
			if(prop.containsKey(key)) {
				line = line.replace(completeKey, prop.getProperty(key));
			}
		}
		
		return line;
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
		logger.debug("rendering Template : ");
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
