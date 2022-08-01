package com.wl.gbl.ge.ssg.frame;

import java.awt.BorderLayout;
import java.awt.Dimension;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class TextWithLabelPanel extends JPanel {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4107898749835063883L;
	
	private JTextField textField = new JTextField();

	public TextWithLabelPanel(String textLabel, String text) {
		this.setLayout(new BorderLayout());

		JLabel label = new JLabel();
		label.setText(textLabel);
		label.setPreferredSize(new Dimension(100, 25));
	    this.add(label,BorderLayout.WEST);
	    
	    textField.setText(text);
		textField.setPreferredSize(new Dimension(400, 25));
		this.add(textField,BorderLayout.CENTER);
		
	}
	
	public String getText() {
		return textField.getText();
	}
	
	

}
