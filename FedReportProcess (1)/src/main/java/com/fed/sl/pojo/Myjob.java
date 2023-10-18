package com.fed.sl.pojo;

import java.io.IOException;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fed.sl.service.ColumnMapServiceImpl;
import com.fed.sl.service.DocumentServiceImpl;
import com.fed.sl.service.FileProcessImpl;
import com.fed.sl.service.ValiadtingFiles;
import com.fed.sl.util.CommonLogger;

@Component("myJob")
public class Myjob {
	final static CommonLogger logger=CommonLogger.getLogger();

	
	
	@Autowired
	FileProcessImpl fileProcess;
	public FileProcessImpl getFileProcess() {
		return fileProcess;
	}


	public void setFileProcess(FileProcessImpl fileProcess) {
		this.fileProcess = fileProcess;
	}


	public void jobSch() throws ParseException, IOException{
		logger.info("hello job invoking");
		logger.debug("in debug");
		System.out.println("hello job invoking");
		fileProcess.validateFile();
		
		
		
		
	}
}
