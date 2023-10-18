package com.fed.sl.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ManyToAny;

@Entity
@Table(name="columnmap")
public class ColumnMap {
	
	/*@ManyToOne
	private Document document;
	@JoinColumn(name="doc_id")*/

	@Id
	private int col_id;
	@Column
	private String name;
	@Column
	private String col_name;
	@Column
	private int sequence_number;
	@Column
	private String datatype;
	@Column
	private String dataformat;
	@Column
	private int doc_id;
	@Column
	private Date create_date;
	
	
	public int getCol_id() {
		return col_id;
	}
	public void setCol_id(int col_id) {
		this.col_id = col_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCol_name() {
		return col_name;
	}
	public void setCol_name(String col_name) {
		this.col_name = col_name;
	}
	public int getSequence_number() {
		return sequence_number;
	}
	public void setSequence_number(int sequence_number) {
		this.sequence_number = sequence_number;
	}
	public String getData_type() {
		return datatype;
	}
	public void setData_type(String datatype) {
		this.datatype = datatype;
	}
	public String getDataformat() {
		return dataformat;
	}
	public void setDataformat(String dataformat) {
		this.dataformat = dataformat;
	}
	public int getDoc_id() {
		return doc_id;
	}
	public void setDoc_id(int doc_id) {
		this.doc_id = doc_id;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	@Override
	public String toString() {
		return "ColumnMap [col_id=" + col_id + ", name=" + name + ", col_name=" + col_name + ", sequence_number="
				+ sequence_number + ", data_type=" + datatype + ", dataformat=" + dataformat + ", doc_id=" + doc_id
				+ ", create_date=" + create_date + "]";
	}
	
	

}
