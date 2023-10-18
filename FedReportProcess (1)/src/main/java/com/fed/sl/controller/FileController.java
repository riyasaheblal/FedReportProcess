package com.fed.sl.controller;

import java.io.IOException;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fed.sl.job.ScheduleJobs;

@Controller
public class FileController {
	@Autowired
	ScheduleJobs scheduleJobs;
	
	@RequestMapping(value = "/callScheduler", method = RequestMethod.GET)
	public void runScheduler() throws ParseException, IOException {
		scheduleJobs.pollFiles();
	}
	
}
