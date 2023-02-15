package com.wl.gbl.ge.ssg.frame;

import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.nio.file.Path;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.wl.gbl.ge.ssg.render.GenerateJinjaFile;
import com.wl.gbl.ge.ssg.utils.CheckManager;

public class MainPanel extends JPanel implements ActionListener {
	
	static final Logger logger = LoggerFactory.getLogger(MainPanel.class);
	
	private static final String CUSTOM_JSON = "Custom json";
	private static final String CUSTOM_TEMPLATE = "Custom template";
	private static final String FOLDER_JSON = "/json";
	private static final String FOLDER_TEMPLATE = "/templates";
	
	private SelectFile jsonSelectFile = new SelectFile("Select json:",CUSTOM_JSON,FOLDER_JSON);
	private SelectFile templateSelectFile = new SelectFile("Select template:",CUSTOM_TEMPLATE,FOLDER_TEMPLATE);
	private TextWithLabelPanel nameSqlText;
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -3583978904761562509L;

	public MainPanel() {
		this.setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();
		
		// Select json file
	    gbc.gridx = 0;
	    gbc.gridy = 0;
	    gbc.gridheight = 1;
	    gbc.gridwidth = 3;
	    gbc.weightx = 1;
	    gbc.weighty = 1;
	    jsonSelectFile.setPreferredSize(new Dimension(500, 50));
	    this.add(jsonSelectFile, gbc);
	    
		// Select template
	    gbc.gridx = 0;
	    gbc.gridy = 1;
	    gbc.gridheight = 1;
	    gbc.gridwidth = 3;
	    templateSelectFile.setPreferredSize(new Dimension(500, 50));
	    this.add(templateSelectFile, gbc);
		
		// File name
	    gbc.gridx = 0;
	    gbc.gridy = 2;
	    gbc.gridheight = 1;
	    gbc.gridwidth = 3;
	    gbc.weightx = 1;    
	    nameSqlText = new TextWithLabelPanel("Sql name:", "result.sql");
	    nameSqlText.setPreferredSize(new Dimension(500, 25));
	    this.add(nameSqlText, gbc);
		
		// Select Button
	    gbc.gridx = 0;
	    gbc.gridy = 3;
	    gbc.gridwidth = 3;
		JButton selectButton = new JButton();
		selectButton.setText("Validate");
		selectButton.addActionListener(this);

	    this.add(selectButton, gbc);
	}
	
	/*public void paintComponent(Graphics g){
		Graphics2D g2d = (Graphics2D)g;
		GradientPaint gp = new GradientPaint(0, 0, Color.ORANGE, 60, 60, Color.BLACK, false);
		g2d.setPaint(gp);
		g2d.fillRect(0, 0, this.getWidth(), this.getHeight());        
	}*/

	@Override
	public void actionPerformed(ActionEvent e) {
		logger.debug("json file: {}",String.valueOf(jsonSelectFile.fileSelected()));
		logger.debug("template file: {}",String.valueOf(templateSelectFile.fileSelected()));
		logger.debug("sql file: {}",nameSqlText.getText());
		String message = "";
		
		try {

			// TODO generer le nom de fichier
			if(jsonSelectFile.fileSelected()!=null && templateSelectFile.fileSelected()!=null && nameSqlText.getText()!=null) {
				GenerateJinjaFile generateJinjaFile = new GenerateJinjaFile();
				Path finalFile = generateJinjaFile.generateFileJinja(jsonSelectFile.fileSelected(), templateSelectFile.fileSelected(), nameSqlText.getText());
				
				boolean check = CheckManager.checkFile(finalFile);
				if(check) {
					message = "Creation completed successfully";
					logger.info(message);
				} else {
					message = "Attention! Suspicious characters (for example: TODO, {{, ...) were found in the generate file. See the log file for more details.";
					logger.warn(message);
				}
			} else {
				message = "Error with files";
				logger.error(message);
			}
		} catch(Exception ex) {
			logger.error(ex.getMessage(),ex);
			message = ex.getMessage();
		}
		
		JOptionPane.showMessageDialog(null, message);
		
	}
	
}
