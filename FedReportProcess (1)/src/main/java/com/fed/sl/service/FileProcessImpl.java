package com.fed.sl.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fed.sl.dao.ColumnMapDao;
import com.fed.sl.dao.DocumentDao;
import com.fed.sl.pojo.ColumnMap;
import com.fed.sl.pojo.Document;
import com.fed.sl.util.CommonConstants;
import com.fed.sl.util.FileProcessUtil;
import com.fed.sl.util.PropertyReader;


@Service("fileProcess")
public class FileProcessImpl {

	
	@Autowired
	ColumnMapDao columnMapDao;

	@Autowired
	DocumentDao documentDao;
	
	public ColumnMapDao getColumnMapDao() {
		return columnMapDao;
	}

	public void setColumnMapDao(ColumnMapDao columnMapDao) {
		this.columnMapDao = columnMapDao;
	}

	public DocumentDao getDocumentDao() {
		return documentDao;
	}

	public void setDocumentDao(DocumentDao documentDao) {
		this.documentDao = documentDao;
	}

	public ArrayList<String> checkFile(){
		File file = new File(PropertyReader.getProperty(CommonConstants.PATH_FILES));
		ArrayList<String> textFiles = new ArrayList<String>();
		for (File f1: file.listFiles() ){
			if(f1.getName().endsWith(CommonConstants.csv) || f1.getName().endsWith(CommonConstants.txt)){
				textFiles.add(f1.getName());
			}
			else {
				System.out.println("FileProcessImpl.checkFile()::NO Files available ");
			}
		}
		return textFiles;
	}

	public String validateFile() throws ParseException, IOException{
		List<Document> list= documentDao.listDocuments();

		if(list!=null && list.size()>0){
			ArrayList<String> file= checkFile();
			if(file!=null && file.size()>0){
				for (String fullfilename : file) {
					ArrayList<String> str=filenameSplit(fullfilename);
					String filename=str.get(0);
					for (Document document : list) {
						String tableName=document.getDoc_name();
						String separator=document.getSeparator();
						String fileExt=str.get(2);
						String dbExt=document.getFile_extension();
						if (filename.equals(tableName) && fileExt.equals(dbExt)){
								String fileDate=str.get(1);
								String filepath=PropertyReader.getProperty(CommonConstants.PATH_FILES);
								SimpleDateFormat format1 = new SimpleDateFormat(PropertyReader.getProperty(CommonConstants.DATEFORMAT_FILE));
								SimpleDateFormat format2 = new SimpleDateFormat(PropertyReader.getProperty(CommonConstants.DATEFORMAT_DB));
								Date date = format1.parse(fileDate);
								
								System.out.println(date);
								
								List<ArrayList<String>> dataList = ReadExcelFile.readText(filepath+fullfilename, separator);
								List<ColumnMap> columnList=columnMapDao.listColumns(document.getDoc_id());
								
								String query=FileProcessUtil.convertDataToQuery(dataList, columnList, document, date);
								try {
									columnMapDao.insertToTemp(query);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
							else {
								System.out.println("File extension is not correct   "+fullfilename);
							}
					}
				}
			}else{
				System.out.println("FileProcessImpl.validateFile()::No files available in the path");
			}
		}
		return null;
	}

	public static ArrayList<String> filenameSplit(String filenamestr){
		ArrayList<String> splited=new ArrayList<String>();
		try{
			int index = filenamestr.lastIndexOf("_");
			String name=filenamestr.substring(0, index);
			String str[]=filenamestr.split("_");
			//String name=str[0];
			String dateExt=str[str.length-1];

			String string[]=dateExt.split("\\.");
			String date=string[0];
			String extension=string[string.length-1];

			splited.add(name);
			splited.add(date);
			splited.add(extension);
			System.out.println(name+"\t"+date+"\t"+extension);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return splited;
	}
}
