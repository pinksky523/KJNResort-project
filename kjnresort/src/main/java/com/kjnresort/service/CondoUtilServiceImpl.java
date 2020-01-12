package com.kjnresort.service;

import java.util.Date;
import java.util.List;

import com.kjnresort.mapper.CondoUtilMapper;
 
public class CondoUtilServiceImpl implements CondoUtilSerivce {
	CondoUtilMapper mapper;
	public List<String> getRoomTypeList(Date checkIn,Date checkOut){
		//사용가능한 방타입 가져오기
		return null;
	}
	public int utilRoom(String roomType,Date checkIn,Date checkOut) {
		return 0;
	}
}
