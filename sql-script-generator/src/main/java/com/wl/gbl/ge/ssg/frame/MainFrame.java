package com.wl.gbl.ge.ssg.frame;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class MainFrame extends JFrame {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -1251822316799646874L;

	public MainFrame(){
		this.setTitle("Sql Script Generator");
		this.setSize(600, 400);
		this.setLocationRelativeTo(null); //Center the frame
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
		
		JPanel selectPanel = new MainPanel();
		selectPanel.setSize(600, 400);
		
		this.setContentPane(selectPanel);
		this.setVisible(true);
	}
	
}
