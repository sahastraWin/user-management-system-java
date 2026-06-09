package com.person;

import java.util.ArrayList;
import java.util.Date;

import com.qualification.QualificationDTO;

public class PersonDTO {
	int id;
	String name;
	String mobileNumber;
	String emailId;
	Date dob;
	
	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	String gender;
	String state;
	String city;
	
	ArrayList<QualificationDTO> qualificationList;

	public ArrayList<QualificationDTO> getQualificationList() {
		return qualificationList;
	}

	public void setQualificationList(ArrayList<QualificationDTO> qualificationList) {
		this.qualificationList = qualificationList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public ArrayList<QualificationDTO> getQualification() {
		return qualificationList;
	}

	public void setQualification(ArrayList<QualificationDTO> qualification) {
		this.qualificationList = qualification;
	}

}