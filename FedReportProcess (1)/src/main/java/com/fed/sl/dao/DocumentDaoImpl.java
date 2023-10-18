package com.fed.sl.dao;

import java.sql.SQLClientInfoException;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.fed.sl.pojo.Document;

@Repository("documentDao")
@Transactional
public class DocumentDaoImpl implements DocumentDao {

	@Autowired
	private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
    	System.out.println("DocumentDaoImpl.setSessionFactory()::***********");
        this.sessionFactory = sessionFactory;
    }

    @SuppressWarnings("unchecked")
    //@Transactional
	public List<Document> listDocuments(){
    	System.out.println("DocumentDaoImpl.listDocuments()::start with ::"+sessionFactory);
    	Session session=sessionFactory.openSession();
    	//Transaction tx=session.getTransaction();
    	Query query = session.createQuery("from Document");
		List<Document> documentList = query.list();
		session.close();
		return documentList;
	}

}
