package com.fed.sl.pojo;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "audit")
public class Audit {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column
	private Date process_date;
	@Column
	private Date file_date;
	@Column
	private boolean status;
	@Column
	private String filename;
	@Column
	private Date create_date;
	@Column
	private int doc_id;
	@Column
	private String mail_triggered;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getProcess_date() {
		return this.process_date;
	}

	public void setProcess_date(Date process_date) {
		this.process_date = process_date;
	}

	public Date getFile_date() {
		return this.file_date;
	}

	public void setFile_date(Date file_date) {
		this.file_date = file_date;
	}

	public boolean isStatus() {
		return this.status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Date getCreate_date() {
		return this.create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public int getDoc_id() {
		return this.doc_id;
	}

	public void setDoc_id(int doc_id) {
		this.doc_id = doc_id;
	}

	public String getMail_triggered() {
		return this.mail_triggered;
	}

	public void setMail_triggered(String mail_triggered) {
		this.mail_triggered = mail_triggered;
	}

	public String toString() {
		return "Audit [id=" + this.id + ", process_date=" + this.process_date + ", file_date=" + this.file_date
				+ ", status=" + this.status + ", filename=" + this.filename + ", create_date=" + this.create_date
				+ ", doc_id=" + this.doc_id + ", mail_triggered=" + this.mail_triggered + "]";
	}
}