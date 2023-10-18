package com.fed.sl.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fed.sl.pojo.ColumnMap;
import com.fed.sl.util.CommonLogger;

@Repository("columnMapDao")
@Transactional
public class ColumnMapDaoImpl implements ColumnMapDao{

	@Autowired
	private SessionFactory sessionFactory;
	static CommonLogger logger = new CommonLogger();

	public void setSessionFactory(SessionFactory sessionFactory) {
		System.out.println("DocumentDaoImpl.setSessionFactory()::***********");
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	
	public List<ColumnMap> listColumns(Integer docId){
		System.out.println("DocumentDaoImpl.listDocuments()::start with ::"+sessionFactory);
		Session session=sessionFactory.openSession();
		List<ColumnMap> columnList = new ArrayList<ColumnMap>();
		try{
		session.beginTransaction();
		Transaction tx=session.getTransaction();
		Query query = session.createQuery("from ColumnMap where doc_id=:docId order by sequence_number");
		query.setInteger("docId", docId);
		columnList = query.list();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return columnList;
	}
	
	public void insertToTemp(String sql) throws SQLException{
		Session session=sessionFactory.openSession();
		try{
		session.beginTransaction();
		Transaction tx=session.getTransaction();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
		tx.commit();
		}catch (Exception e) {
			// TODO: handle exception
			logger.info("Exception while inserting data in temptable ::: "+e );
			e.printStackTrace();
		}finally{
		 session.close();
		}

	}

	@Override
	public void insertToTemp(List<String> var1) throws SQLException {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		try{
			Transaction tx = session.getTransaction();
			tx.begin();
			Iterator<String> var5 = var1.iterator();
			while (var5.hasNext()) {
				String sql = (String) var5.next();
				Query query = session.createSQLQuery(sql);
				query.executeUpdate();
			}
			tx.commit();
			
		}catch (Exception e) {
			// TODO: handle exception
			logger.info("Exception while inserting data in temptable ::: "+e );
			e.printStackTrace();
		}
		finally{
			session.close();
		}
		
	}

	
}
