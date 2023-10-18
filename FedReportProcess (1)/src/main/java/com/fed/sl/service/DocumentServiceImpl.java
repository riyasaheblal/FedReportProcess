package com.fed.sl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fed.sl.dao.DocumentDao;
import com.fed.sl.pojo.Document;


@Service("documents")
//@Transactional
public class DocumentServiceImpl implements DocumentService{

	@Autowired
	private DocumentDao documentDao;

	public DocumentDao getDocumentDao() {
		return documentDao;
	}

	public void setDocumentDao(DocumentDao documentDao) {
		this.documentDao = documentDao;
	}

	public List<Document> listDocuments() {
		// TODO Auto-generated method stub
		List<Document> list= documentDao.listDocuments();
		
		for(Document d : list){
			System.out.println("Document List::"+d);
		}
		
		return documentDao.listDocuments();
	}
	
	
}
