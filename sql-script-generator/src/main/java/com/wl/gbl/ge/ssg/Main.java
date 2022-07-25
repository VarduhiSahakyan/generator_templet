package com.wl.gbl.ge.ssg;

public class Main {

	
	public static void main(String[] args) {

		GenerateFile generateFile = new GenerateFile();
		generateFile.generateFile("/ACS_BO_PROD.properties","/ACS_BO_script_template_v3.sql","result.sql");
		
	}
	

	
	
}
