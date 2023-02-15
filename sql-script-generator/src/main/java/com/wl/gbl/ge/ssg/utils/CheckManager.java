package com.wl.gbl.ge.ssg.utils;

import java.io.FileNotFoundException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CheckManager {
	
	static final Logger logger = LoggerFactory.getLogger(CheckManager.class);
	
	public static boolean checkFile(Path file) {
		boolean result = true; 
		
		List<String> searchList = new ArrayList<>();
		searchList.add("TODO");
		searchList.add("{{");
		searchList.add("{%-");
		try(Scanner scan = new Scanner(file.toFile())) {
	        while(scan.hasNext()){
	            String line = scan.nextLine().toString();
	            for(String search : searchList) {
	            	if(line!=null && search!=null && line.toLowerCase().contains(search.toLowerCase())) {
	            		logger.warn("{} found in line: {}",search,line);
	            		result = false;
	                }
	            }
	            
	        }
	        
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	
}
