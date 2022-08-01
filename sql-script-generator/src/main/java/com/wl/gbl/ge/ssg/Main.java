package com.wl.gbl.ge.ssg;

public class Main {

	
	public static void main(String[] args) {

		GenerateFile generateFile = new GenerateFile();
		if(args.length==0) {
			generateFile.generateFile("/ACS_BO_PROD.properties", "/ACS_BO_script_template_v3.sql", "result.sql");
			generateFile.generateFileJinjaFromClasspath("/ACS_HUB_TRIODOS_IAT.json", "/ACS_CR_H5G_script_template.j2", "ACS_CR_H5G_TRIODOS.sql");
			generateFile.generateFileJinjaFromClasspath("/ACS_HUB_TRIODOS_IAT.json", "/ACS_ASR_script_template.j2" , "ACS_ASR_TRIODOS.sql");
		}else if(args.length==3){
			generateFile.generateFileJinjaFromLocal(args[0], args[1], args[2]);
		}
	}
	

	
	
}
