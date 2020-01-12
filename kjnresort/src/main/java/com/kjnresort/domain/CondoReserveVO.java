package com.kjnresort.domain;

import java.sql.Date;

public class CondoReserveVO {
	public long reservoNo;
	public Date reserveDate;
	public int status;
	public String roomType;
	public Date checkIn;
	public Date checkOut;
	public int nights;
	public String id;
	public String name;
	public String phoneNumber;
	public int review;
	
	public long getReservoNo() {
		return reservoNo;
	}
	public void setReservoNo(long reservoNo) {
		this.reservoNo = reservoNo;
	}
	public Date getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public Date getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}
	public Date getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}
	public int getNights() {
		return nights;
	}
	public void setNights(int nights) {
		this.nights = nights;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public int getReview() {
		return review;
	}
	public void setReview(int review) {
		this.review = review;
	}
	
}
