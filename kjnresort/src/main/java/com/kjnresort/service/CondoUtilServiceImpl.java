package com.kjnresort.service;

import java.util.Date;
import java.util.List;

import com.kjnresort.mapper.CondoUtilMapper;
 
public class CondoUtilServiceImpl implements CondoUtilSerivce {
	CondoUtilMapper mapper;
	public List<String> getRoomTypeList(Date checkIn,Date checkOut){
		//��밡���� ��Ÿ�� ��������
		return null;
	}
	public int utilRoom(String roomType,Date checkIn,Date checkOut) {
		return 0;
	}
}
