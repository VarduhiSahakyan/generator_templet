package com.wl.gbl.ge.ssg.frame;

public class FileInformation {

	private TypeFileEnum type;
	private String filePath;

	
	public FileInformation(TypeFileEnum type, String filePath) {
		this.type= type;
		this.filePath = filePath;
	}

	public TypeFileEnum getType() {
		return type;
	}

	public String getFilePath() {
		return filePath;
	}

	@Override
	public String toString() {
		return "FileInformation [type=" + type + ", filePath=" + filePath + "]";
	}
	
	
}
