package com.fed.sl.util;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * @author Pradeep
 *@Description To fetcch values fro properties file
 */
public class PropertyReader {
	private static ResourceBundle bundle;
	//private static final CommonLogger logger=CommonLogger.getLogger();

	public static void loadApplicationPropFile() {
		bundle = ResourceBundle.getBundle(CommonConstants.CONFIG);
	}

	public static String getProperty(String key) {
		String value = null;
		try {
			if (bundle == null) {
				loadApplicationPropFile();
			}
			value = (String) bundle.getObject(key);
		} catch (MissingResourceException e) {
			System.out.println("Exception"+e);
		}
		

		return value;
	}
}
