package com.wl.gbl.ge.ssg.frame;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.stream.Stream;

import javax.swing.DefaultListCellRenderer;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SelectFile extends JPanel implements ActionListener {
	
	static final Logger logger = LoggerFactory.getLogger(SelectFile.class);
	
	private static final String SELECT_FILE_TEXT = "select your file";
	
	private JLabel choice = new JLabel();
	private JButton buttonOpenSelectFileOnComputer = new JButton();
	private JComboBox<Object> selectComboBox;
	private Path lastCustomSelectedPath = null;
	private String folderWithFiles = null;

	/**
	 * 
	 */
	private static final long serialVersionUID = -6106184106400814388L;

	public SelectFile(String title, String optionCustom, String folder) {
		this.setLayout(new BorderLayout());
		this.folderWithFiles = folder;
		
		JLabel jsonLabel = new JLabel();
	    jsonLabel.setText(title);
	    jsonLabel.setPreferredSize(new Dimension(100, 10));
	    this.add(jsonLabel,BorderLayout.WEST);
	    
	    List<Object> listAllObject = new ArrayList<>();
	    
	    boolean enabledButton = true;
	    
	    List<Path> listPaths = new ArrayList<>();
		try {
			listPaths = searchFile(folder);
			if(listPaths!=null && listPaths.size()>0) {
				listAllObject.addAll(listPaths);
				enabledButton = false;
		    }
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
	    listAllObject.add(optionCustom);
	    Vector<Object> listObjectVector = new Vector<>(listAllObject);
	    selectComboBox = new JComboBox<>(listObjectVector);
	    selectComboBox.setRenderer(new DefaultListCellRenderer() {
            /**
			 * serialVersionUID
			 */
			private static final long serialVersionUID = -5265804929900511913L;

			@Override
            public Component getListCellRendererComponent(JList<?> list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
                super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
                if(value instanceof Path) {
                	Path path = (Path) value;
                    setText(path.getFileName().toString());
                } else if(value instanceof File) {
                	setText("file...");
                } else {
                	setText(optionCustom);
                }
                return this;
            }
        } );
	    selectComboBox.addItemListener(new ItemStateCombobox());
	    selectComboBox.setPreferredSize(new Dimension(300, 10));
	    this.add(selectComboBox,BorderLayout.CENTER);
	    
		buttonOpenSelectFileOnComputer.setText("Select file");
		buttonOpenSelectFileOnComputer.addActionListener(this);
		buttonOpenSelectFileOnComputer.setEnabled(enabledButton);
		this.add(buttonOpenSelectFileOnComputer,BorderLayout.EAST);
		
		this.add(choice,BorderLayout.SOUTH);
		addFilename();
	}
	
	public FileInformation fileSelected() {
		FileInformation finalFile = null;
		
		if(selectComboBox!=null) {
			Object selectedObject = selectComboBox.getSelectedItem();
			if(selectedObject!=null && selectedObject instanceof Path) {
				Path path = (Path)selectedObject;
				logger.debug("name in jar: {}",path.getFileName());				
				if(this.folderWithFiles!=null && path.toString().startsWith(this.folderWithFiles)){
					finalFile = new FileInformation(TypeFileEnum.CLASSPATH, path.toString());
				} else {
					finalFile = new FileInformation(TypeFileEnum.LOCAL, path.toString());
				}
			} else {
				Path path = lastCustomSelectedPath;
				logger.debug("name in custom: {}",path.getFileName());
				finalFile = new FileInformation(TypeFileEnum.LOCAL, path.toString());
			}
		}

		return finalFile;
	}

	@Override
	public void actionPerformed(ActionEvent a) {
		final JFileChooser fc = new JFileChooser();
		try {
			fc.setCurrentDirectory(new File(SelectFile.class.getProtectionDomain().getCodeSource().getLocation().toURI()));
		} catch (URISyntaxException e) {
			logger.warn(e.getMessage(),e);
		}
		fc.showOpenDialog(this);

		if(fc.getSelectedFile()!=null) {
			lastCustomSelectedPath = fc.getSelectedFile().toPath();
			choice.setText(fc.getSelectedFile().getAbsolutePath());
		}
	}

	private List<Path> searchFile(String folder) throws URISyntaxException, IOException {
		List<Path> listPathFile = new ArrayList<>();
		
		logger.debug("searchFile with folder: {}", folder);
		URI uriProperties = SelectFile.class.getResource(folder).toURI();
		//File folderFile = Paths.get(uriProperties).toFile();
		FileSystem fileSystem=null;
		
		Path myPath;
		if (uriProperties.getScheme().equals("jar")) {
			fileSystem = FileSystems.newFileSystem(uriProperties, Collections.<String, Object>emptyMap());
			logger.debug("fileSystem:"+fileSystem.toString());
			myPath = fileSystem.getPath(folder);
			
		} else {
			myPath = Paths.get(uriProperties);
		}
		logger.debug("myPath:"+myPath);
        
		
		try (Stream<Path> walk = Files.walk(myPath, 1)) {
			for (Iterator<Path> it = walk.iterator(); it.hasNext();){
				Path path = it.next();
				
				logger.debug("path:"+path);
				logger.debug("path.getFileName():"+path.getFileName());
				logger.debug("isRegularFile:"+Files.isRegularFile(path));
				
				if(Files.isRegularFile(path)) {
					Path newPath = Paths.get(path.toUri());
					listPathFile.add(newPath);
				}
				
			}
		}
		

		if(fileSystem!=null && fileSystem.isOpen()) {
			fileSystem.close();
		}
		
		return listPathFile;
	}
	
	
	class ItemStateCombobox implements ItemListener{
		public void itemStateChanged(ItemEvent e) {
			if(e.getItem() instanceof File) {
				buttonOpenSelectFileOnComputer.setEnabled(false);
			} else {
				buttonOpenSelectFileOnComputer.setEnabled(true);
			}
			addFilename();
		}
	}
	
	private void addFilename() {

		String filename = SELECT_FILE_TEXT;
		Object selectedObject = selectComboBox.getSelectedItem();
		if(selectedObject!=null && selectedObject instanceof Path) {
			filename = ((Path)selectedObject).getFileName().toString();
		} else if(lastCustomSelectedPath!=null) {
			filename = lastCustomSelectedPath.getFileName().toString();
		}
		
		choice.setText("Selected filename: "+filename);
	}
	
}
