package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CondoReserveVO { //콘도리절브브이오
	public long reserveNo;
	public Date reserveDate;
	public int status;
	public String roomType;
	public int roomNo;
	public Date checkIn;
	public Date checkOut;
	public int nights;//자동계산하기
	public int price;
	public String id;
	public int review;
	
	
}
