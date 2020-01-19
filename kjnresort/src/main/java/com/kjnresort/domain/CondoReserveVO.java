package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CondoReserveVO { //콘도리절브브이오
	private long reserveNo;
	private Date reserveDate;
	private int status;
	private String roomType;
	private int roomNo;
	private Date checkIn;
	private Date checkOut;
	private int nights;//자동계산하기
	private int price;
	private String id;
	private int review;
	
	
}
