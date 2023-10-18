package com.fed.sl.service;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class ReadExcelFile {


	//code for reading data from excel file
	/* public static List<ArrayList<String>> readExcel() throws BiffException, IOException {
    String FilePath = "E:\\Test.xls";
    List<ArrayList<String>> li = new ArrayList<ArrayList<String>>();
    FileInputStream fs = new FileInputStream(FilePath);
    Workbook wb = Workbook.getWorkbook(fs);

    // TO get the access to the sheet
    Sheet sh = wb.getSheet("Sheet1");

    // To get the number of rows present in sheet
    int totalNoOfRows = sh.getRows();

    // To get the number of columns present in sheet
    int totalNoOfCols = sh.getColumns();

    for (int row = 0; row < totalNoOfRows; row++) {
      ArrayList<String> rowList = new ArrayList<String>();
      for (int col = 0; col < totalNoOfCols; col++) {
        // System.out.print(sh.getCell(col, row).getContents() + "\t");
        rowList.add(sh.getCell(col, row).getContents());
      }
      li.add(rowList);
    }
    return li;
  }*/

	public static List<ArrayList<String>> readText(String filePath, String seperator) throws IOException{
		List<ArrayList<String>> li = new ArrayList<ArrayList<String>>();
		String line = "";
		String splitBy="";

		if(seperator.equalsIgnoreCase("pipe")){
			splitBy = "\\|";
		}
		else if(seperator.equalsIgnoreCase("comma")){
			splitBy = ",";
		}

		File f = new File(filePath);
		BufferedReader br =new BufferedReader(new FileReader(f));
		FileReader fr= new FileReader(f);
		LineNumberReader lnr =new LineNumberReader(fr);
		lnr.skip(Long.MAX_VALUE);
		int linenumber =lnr.getLineNumber();
		System.out.println("Total number of lines : " + linenumber);
		lnr.close();
		while ((line = br.readLine()) != null) {
			line=line.trim();
			if(line!=null && line.length() !=0 && line!=""){
				String raw=checkData(line);
				String[] data = raw.split(splitBy);
				ArrayList<String> rowList= new ArrayList<String>(Arrays.asList(data));
				li.add(rowList);
			}
		}
		System.out.println(li.size());
		//System.out.println(Arrays.toString(li.toArray()));

		return li;
	}

	public static String checkData(String value){
		String singleQ = value;
		String doublequ= "";
		
		if(singleQ!=null){
			return singleQ.replace("'", "''");
		}else{
			return null;
		}
		
		/*
		System.out.println("With single quotes: "+singleQ); 
		StringBuffer doubleQ = new StringBuffer(); 
		int ind = singleQ.indexOf("'"); 
		int placeholder=0; 
		if(ind != -1){
			while(ind != -1) { 
				doubleQ.append(singleQ.substring(placeholder,ind)+"'"); 
				placeholder = ind; 
				ind = singleQ.indexOf("'",placeholder+1); 
				if(ind == -1) 
					doubleQ.append(singleQ.substring(placeholder)); 
			} 
			System.out.println("With double quotes: "+doubleQ);
		}
		else{
			doubleQ.append(singleQ);
			System.out.println("With double quotes: "+doubleQ);
		}
		doublequ=doubleQ.toString();
		return doublequ;*/

	}


	public static void main(String args[]) throws BiffException, IOException, SQLException {
		//ReadExcelFile DT = new ReadExcelFile();
		//read excel 
		//List<ArrayList<String>> li = DT.readExcel();
		//read text
		//List<ArrayList<String>> li = DT.readText();


		/*
		 * String row[][] = { { "1", "col1", "T", "" }, { "2", "col2", "I", "" }, { "3", "col3", "T",
		 * "yyyy-mm-dd" } }; String doc[] = {}; String arr[][] = { { "a", "2", "218-02-01" }, { "b",
		 * "3d", "218-02-01" } };
		 */
		// char art[][] = DT.listToArray(li);
		//ExtractInfo.readData(li);
		//String query=ExtractInfo.readData(li);
		//ExtractInfo.getData();
		//ExtractInfo ex=new ExtractInfo();
		//ex.showData();
		//ex.getTable();
		//ex.processTable(query);
		// DT.print();
		//System.out.println("ReadExcelFile.main()"+checkData(null));

	}
}
