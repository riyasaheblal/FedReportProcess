package com.fed.sl.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fed.sl.pojo.ColumnMap;
import com.fed.sl.pojo.Document;

public class FileProcessUtil {

	public static String convertDataToQuery(List<ArrayList<String>> list,List<ColumnMap> columnList,Document document, Date date){
		String query=null;
		String tablename=document.getTable_name();
		String hasHeaderData=document.getHas_header();
		try {

			//ArrayList<ColumnMap> row1=new ArrayList<ColumnMap>();
			//row1=getData();
			String insert = "insert into "+tablename+"(define_date,source,";
			String insertValues = "values ";
			int size=list.size();
			if (hasHeaderData.equals("Y")){
				for (int i = 1; i <size; i++) {
					int l = list.get(i).size();
					//System.out.println(i);
					//System.out.println(l);
					ArrayList<String> al = list.get(i);
					for (int j = 0; j < list.get(i).size(); j++) {
						//System.out.println("ExtractInfo.main()::" + al.get(j) + " - " + row1.get(j).getDataType());
						if (i == 1 && j == 0)
							insert += columnList.get(j).getCol_name();
						else if (i!=1 && j==0)
							System.out.println();
						else if(i==1 && j!=0)
							insert += "," + columnList.get(j).getCol_name();
						if (i == 1 && j == 0)
							insertValues += "('"+date+"',"+"'"+document.getSource()+"'," + parseField(al.get(j), columnList.get(j).getCol_name(), columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i);
						else if (j == 0)
							insertValues += ",('"+date+"',"+"'"+document.getSource()+"'," + parseField(al.get(j), columnList.get(j).getCol_name(), columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i);
						else
							insertValues += "," + parseField(al.get(j), columnList.get(j).getCol_name(),columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i);
					}
					insertValues += ")";
				}
			}
			else{
				for (int i = 0; i <size; i++) {
					int l = list.get(i).size();
					//System.out.println(i);
					//System.out.println(l);
					ArrayList<String> al = list.get(i);
					for (int j = 0; j < list.get(i).size(); j++) {
						//System.out.println("ExtractInfo.main()::" + al.get(j) + " - " + row1.get(j).getDataType());
						if (i == 0 && j == 0)
							insert += columnList.get(j).getCol_name();
						else if (i!=0 && j==0)
							System.out.println();
						else if(i==0 && j!=0)
							insert += "," + columnList.get(j).getCol_name();
						if (i == 0 && j == 0)
							insertValues += "('"+date+"',"+"'"+document.getSource()+"',"+ parseField(al.get(j), columnList.get(j).getCol_name(), columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i+1);
						else if (j == 0)
							insertValues += ",('"+date+"',"+"'"+document.getSource()+"',"+ parseField(al.get(j), columnList.get(j).getCol_name(), columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i+1);
						else
							insertValues += "," + parseField(al.get(j), columnList.get(j).getCol_name(),columnList.get(j).getData_type(), columnList.get(j).getDataformat(),i+1);
					}
					insertValues += ")";
				}
			}

			insert += ")";

			query=insert+" "+insertValues;
			//System.out.println(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return query;
	}

	private static String parseField(Object data, String colName, String strDataType,
			String strDataFormat,int lineNo) throws Exception {
		String strTextFrom = "";
		//System.out.println("ExtractInfo.parseField()::"+data.toString());
		//System.out.println("ExtractInfo.parseField()::" + data.getClass().getName());
		if (data != null) {
			strTextFrom = (String) data;
		} else {
			// throw new Exception("field: "+colName);
		}

		String strTexto = "";
		if (strDataType.equals("date")) {
			//if(data!=null && strTextFrom.equals("")){
			if(data!=null && !"".equals(strTextFrom)){
				if(strDataFormat!=null && !"null".equalsIgnoreCase(strTextFrom)){
					try{
						strTextFrom = (String) data;
						SimpleDateFormat format1 = new SimpleDateFormat(strDataFormat);
						SimpleDateFormat format2 = new SimpleDateFormat(PropertyReader.getProperty(CommonConstants.DATEFORMAT_DB));
						Date date = format1.parse(strTextFrom);
						return "'"+format2.format(date)+"'";
					}catch (Exception e) {
						throw new Exception("field: " + colName + " is not in proper date format. value::"+strTextFrom+" dateformat::"+strDataFormat+"  "+data+"  line number "+lineNo);
					}
				}
				else if(strTextFrom.equalsIgnoreCase("null")){
					return null;
				}

				else{
					throw new Exception("field: " + colName + " date format is not defined for type date."+data+"  line number "+lineNo);
				}
			}
			return null;
		} else if (strDataType.equals("numeric")) {

			if (strTextFrom.isEmpty() || strTextFrom.equalsIgnoreCase("null")){
				return "0";
			}
			if (isNumeric(strTextFrom)) {
				return strTextFrom;
			} else {
				throw new Exception("field: " + colName + " is not of type Integer"+data+"  line number "+lineNo);
			}
		} 
		else {
			if (strTextFrom.isEmpty()){
				return null;
			}
			else {
				return "'" + strTextFrom + "'";
			}
		}
	}

	public static boolean isNumeric(String str) {
		return str.matches("-?.?\\d+(\\.\\d+)?");
	}
}
