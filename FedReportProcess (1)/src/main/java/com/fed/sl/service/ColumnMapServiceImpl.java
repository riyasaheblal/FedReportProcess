package com.fed.sl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fed.sl.dao.ColumnMapDao;
import com.fed.sl.pojo.ColumnMap;
import com.fed.sl.pojo.Document;

@Service("columns")
public class ColumnMapServiceImpl implements ColumnMapService{

	@Autowired
	private ColumnMapDao columnMapDao;

	public ColumnMapDao getColumnMapDao() {
		return columnMapDao;
	}

	public void setColumnMapDao(ColumnMapDao columnMapDao) {
		this.columnMapDao = columnMapDao;
	}

	public List<ColumnMap> listColumns() {
		// TODO Auto-generated method stub
		List<ColumnMap> list= columnMapDao.listColumns(1);

		for(ColumnMap c : list){
			System.out.println("column List::"+c);
		}
		return columnMapDao.listColumns(1);
	}

}
