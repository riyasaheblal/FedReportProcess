package com.fed.sl.job;

import java.io.IOException;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;

import com.fed.sl.service.FileProcessImpl;
import com.fed.sl.util.CommonLogger;

public class ScheduleJobs {


	final static CommonLogger logger=CommonLogger.getLogger();
	
	@Autowired
	FileProcessImpl fileProcess;
	public FileProcessImpl getFileProcess() {
		return fileProcess;
	}


	public void setFileProcess(FileProcessImpl fileProcess) {
		this.fileProcess = fileProcess;
	}

	public void pollFiles() throws ParseException, IOException{
		logger.info("hello job invoking");
		logger.debug("in debug");
		System.out.println("hello job invoking");
		
		fileProcess.validateFile();
		
	}

}
