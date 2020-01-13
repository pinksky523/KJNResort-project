package com.kjnresort.mapper;

import java.util.Date;
import java.util.List;

public interface CondoUtilMapper {
	public List<String> getRoomTypeList(Date checkIn,Date checkOut); //사용가능한 방타입 가져오기
	public int utilRoom(String roomType,Date checkIn,Date checkOut); //방예약
}
