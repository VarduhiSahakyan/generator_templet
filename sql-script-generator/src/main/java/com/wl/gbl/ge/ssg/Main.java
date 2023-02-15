package com.wl.gbl.ge.ssg;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.wl.gbl.ge.ssg.frame.MainFrame;

public class Main {

	static final Logger logger = LoggerFactory.getLogger(Main.class);
	
	public static void main(String[] args) {
		logger.debug("start main");
		
		try {			
			new MainFrame();
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
		}
/*
		GenerateJinjaFile generateFile = new GenerateJinjaFile();
		if(args.length==0) {
			generateFile.generateFileJinjaFromClasspath("/json/ACS_HUB_TRIODOS_IAT.json", "/templates/ACS_CR_H5G_script_template.j2", "ACS_CR_H5G_TRIODOS.sql");
			generateFile.generateFileJinjaFromClasspath("/json/ACS_HUB_TRIODOS_IAT.json", "/templates/ACS_ASR_script_template.j2" , "ACS_ASR_TRIODOS.sql");
		}else if(args.length==3){
			generateFile.generateFileJinjaFromLocal(args[0], args[1], args[2]);
		}*/
		
		logger.debug("end main");
	}
	

	
	
}
