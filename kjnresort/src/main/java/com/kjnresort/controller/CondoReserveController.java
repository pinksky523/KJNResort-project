package com.kjnresort.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.service.CondoReserveService;


@RequestMapping("/condoReserve")
public class CondoReserveController { //한글테스트 오전 9시47분
	CondoReserveService service;
	
	@GetMapping("/list")
	public void reserveList(Model model,Criteria cri) {
		
	}
	
	
	@GetMapping("/get")
	public CondoReserveVO reserveGet(long rno,Model model,Criteria cri) {
		
	}
	
	
	@PostMapping("/confirm")
	public void reserveConfirm(long rno,Model model,Criteria cri) {
		
	}
	
	
	@PostMapping("/cancel")
	public void reserveCancel(long rno,Model model,Criteria cri) {
		
	}
	
	
	@PostMapping("/reserve")
	public String registerReserve(CondoReserveVO crVO,RedirectAttributes rttr) {
		
	}
	
}
