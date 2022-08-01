package com.wl.gbl.ge.ssg.utils;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Date;

import org.apache.maven.model.Model;
import org.apache.maven.model.io.xpp3.MavenXpp3Reader;
import org.codehaus.plexus.util.xml.pull.XmlPullParserException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HeaderManager {
	
	static final Logger logger = LoggerFactory.getLogger(HeaderManager.class);

	public static final String LINESEPARATOR = "\n";
	
	public static void addHeader(Path finalFile, String propertiesFile, String templateFile) throws IOException {
		
		String header = "# Generated by sql-script-generator" + LINESEPARATOR;
		header = header + "# Version: "+ getVersion() + LINESEPARATOR;
		header = header + "# Date: "+ new Date() + LINESEPARATOR;
		header = header + "# Properties file: " + propertiesFile + LINESEPARATOR;
		header = header + "# Template file: "+ templateFile + LINESEPARATOR;
		header = header + LINESEPARATOR;
		
		Files.write(finalFile, header.getBytes(), StandardOpenOption.CREATE, StandardOpenOption.APPEND);
		
		
	}
	
	private static String getVersion() {
		String mavenVersion = null;
		try {
			MavenXpp3Reader reader = new MavenXpp3Reader();
			Model model;
			if ((new File("pom.xml")).exists()) {
				model = reader.read(new FileReader("pom.xml"));
			}else {
	
				model = reader.read(
					new InputStreamReader(
						HeaderManager.class.getResourceAsStream(
							"/META-INF/maven/com.worldline.acs.rbu2.delivery/sql-script-generator/pom.xml"
						)
					)
				);
	
			}
			
			if(model!=null) {
				if(model.getVersion()!=null) {
					mavenVersion = model.getVersion();
				} else if(model.getParent()!=null) {
					mavenVersion = model.getParent().getVersion();
				}
			}
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		} catch (XmlPullParserException e) {
			logger.error(e.getMessage(),e);
		}
		return mavenVersion;
	}
	
	
}
