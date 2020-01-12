package com.kjnresort.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kjnresort.domain.Criteria;


@RequestMapping("/condoReserve")
public class CondoReserve {
 
	//콘도예약목록
	@GetMapping("/list")
	public void reserveList(Model model,Criteria cri) {
		
	}
	
	//콘도예약상세조회
	@GetMapping("/get")
	public void reserveGet(long rno,Model model,Criteria cri) {
		
	}
	
	//콘도예약이용확인
	@PostMapping("/confirm")
	public void reserveConfirm(long rno,Model model,Criteria cri) {
		
	}
	
	//콘도예약취소
	@PostMapping("/cancel")
	public void reserveCancel(long rno,Model model,Criteria cri) {
		
	}
	
	//콘도예약하기
	@PostMapping("/add")
	public void addReserve() { //매개변수에 예약 vo,dao도 추가해주기
		
	}
	
}
