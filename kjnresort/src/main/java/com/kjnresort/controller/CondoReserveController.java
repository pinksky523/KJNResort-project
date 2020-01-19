package com.kjnresort.controller;

import java.security.Principal;
import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.service.CondoReserveService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@RequestMapping("/condoreserve/*")
@AllArgsConstructor
@Controller
public class CondoReserveController { //헐 이제 될거같아
	CondoReserveService service;
	
	@GetMapping("/list")
	public void list(Model model,Criteria cri,Principal principal) {
		
	}
	
	
	@GetMapping("/get")
	public CondoReserveVO get(Long rno,Model model,Criteria cri) {
		return null;
	}
	
	
	@PostMapping("/confirm")
	public void reserveConfirm(CondoReserveVO crvo,Model model,RedirectAttributes rttr,Criteria cri) {
		
	}
	
	
	@PostMapping("/cancel")
	public void reserveCancel(CondoReserveVO crvo,Model model,RedirectAttributes rttr,Criteria cri) {
		
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(CondoReserveVO crVO,RedirectAttributes rttr) {
		return null;
	}
	

	
}
