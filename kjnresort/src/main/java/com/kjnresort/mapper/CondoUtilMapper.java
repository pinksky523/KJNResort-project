package com.kjnresort.mapper;

import java.util.Date;
import java.util.List;

public interface CondoUtilMapper {
	public List<String> getRoomTypeList(Date checkIn,Date checkOut); //��밡���� ��Ÿ�� ��������
	public int utilRoom(String roomType,Date checkIn,Date checkOut); //�濹��
}
