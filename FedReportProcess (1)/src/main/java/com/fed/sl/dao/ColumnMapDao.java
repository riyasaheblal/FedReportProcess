package com.fed.sl.dao;

import java.sql.SQLException;
import java.util.List;

import com.fed.sl.pojo.ColumnMap;

public interface ColumnMapDao {
	
	public List<ColumnMap> listColumns(Integer docId);
	public void insertToTemp(String sql)  throws SQLException;
	public void insertToTemp(List<String> var1) throws SQLException;

}
