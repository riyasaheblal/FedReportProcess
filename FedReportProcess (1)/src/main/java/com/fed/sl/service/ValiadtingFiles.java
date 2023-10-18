package com.fed.sl.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fed.sl.pojo.Document;

@Service("validate")
public class ValiadtingFiles {
	
	@Autowired
    DocumentServiceImpl documents;
	
	public DocumentServiceImpl getDocuments() {
		return documents;
	}

	public void setDocuments(DocumentServiceImpl documents) {
		this.documents = documents;
	}
	
	public ArrayList<Document> validate(){
		List list=documents.listDocuments();
		ArrayList<Document> doc= new ArrayList<Document>(list);
		
		for(int i=0; i<doc.size(); i++){
		
		System.out.println(doc.get(i).getDoc_name()+"    "+doc.get(i).getTable_name());
		}
		return doc;
		
	}
	
	

}
