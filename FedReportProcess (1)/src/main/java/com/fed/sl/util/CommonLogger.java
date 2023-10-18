package com.fed.sl.util;
import java.net.URL;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.helpers.Loader;

public class CommonLogger {
	static Logger logger;
	static Logger loggerD;
	static CommonLogger commonlogger;

	public final void info(String message) {
		logger.info(message);
	}

	public final void error(String message) {
		logger.error(message);
	}

	public final void error(Object message) {
		logger.error(message);
	}

	public final void logError(String message, Throwable th) {
		logger.error(message, th);
	}

	public final void debug(String message) {
		loggerD.debug(message);
	}

	public final void logDebug(String classname, String methodname,
			String message) {
		logger.debug(classname + CommonConstants.DOT + methodname + CommonConstants.SPACE + message);
	}

	public final void logWarn(String classname, String methodname,
			String message) {
		logger.warn(classname + CommonConstants.DOT + methodname + CommonConstants.SPACE + message);
	}

	public final void logInfo(String classname, String methodname,
			String message) {
		logger.info(classname + CommonConstants.DOT + methodname + CommonConstants.SPACE + message);
	}

	public final void logTrace(String classname, String methodname,
			String message) {
		logger.info(classname + CommonConstants.DOT + methodname + CommonConstants.SPACE + message);
	}

	public final void logError(String classname, String methodname,
			String message) {
		logger.fatal(classname + CommonConstants.DOT + methodname + CommonConstants.SPACE + message);
	}

	public static CommonLogger getLogger() {
		if (commonlogger == null) {
			commonlogger = new CommonLogger();
		}

		//URL url = Loader.getResource(CommonConstants.LOG4J);
		//PropertyConfigurator.configure(url);
		logger = Logger.getLogger("info");
		loggerD = Logger.getLogger("error");
		return commonlogger;
	}

	public boolean isDebugEnabled() {
		return logger.isDebugEnabled();
	}
}
