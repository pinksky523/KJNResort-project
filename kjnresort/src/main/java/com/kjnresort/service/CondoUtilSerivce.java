package com.kjnresort.service;

import java.util.Date;
import java.util.List;

public interface CondoUtilSerivce {
	public List<String> getRoomTypeList(Date checkIn,Date checkOut); //��밡���� ��Ÿ�� ��������
	public int utilRoom(String roomType,Date checkIn,Date checkOut);
}
