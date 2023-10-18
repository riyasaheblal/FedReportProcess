package com.fed.sl.pojo;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="document")
public class Document {
	
	/*@OneToMany(mappedBy="document")
	private Set<ColumnMap> columnmap;*/
	

	@Id
	private int doc_id;
	@Column
	private String doc_name;
	@Column
	private String table_name;
	@Column
	private Date create_date;
	@Column
	private String has_header;
	@Column
	private String filename;
	@Column
	private String file_extension;
	@Column
	private String separator;
	@Column
	private String source;
	
	
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public int getDoc_id() {
		return doc_id;
	}
	public void setDoc_id(int doc_id) {
		this.doc_id = doc_id;
	}
	public String getDoc_name() {
		return doc_name;
	}
	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getHas_header() {
		return has_header;
	}
	public void setHas_header(String has_header) {
		this.has_header = has_header;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFile_extension() {
		return file_extension;
	}
	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}
	public String getSeparator() {
		return separator;
	}
	public void setSeparator(String separator) {
		this.separator = separator;
	}
	
	
	@Override
	public String toString() {
		return "Document [doc_id=" + doc_id + ", doc_name=" + doc_name + ", table_name=" + table_name + ", create_date="
				+ create_date + ", has_header=" + has_header + ", filename=" + filename + ", file_extension="
				+ file_extension + ", separator=" + separator + ", source=" + source + "]";
	}
	
	
	
	
}
