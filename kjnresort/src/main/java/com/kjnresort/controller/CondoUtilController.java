package com.kjnresort.controller;

import java.util.Date;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;

import com.kjnresort.service.CondoUtilSerivce;

@RequestMapping("/condoutil")
public class CondoUtilController {
	CondoUtilSerivce service;

	@PostMapping("/getavailableroomtype")
	public List<String> getAvailableRoomType(Date checkIn,Date checkOut ){
		return null;
	}
	
	@PostMapping("/utilroom")
	public void utilRoom(String roomType,Date checkIn,Date checkOut) {
		
	}
}
