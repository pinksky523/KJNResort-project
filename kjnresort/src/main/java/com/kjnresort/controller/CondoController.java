package com.kjnresort.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoVO;

import com.kjnresort.domain.Criteria;
import com.kjnresort.service.CondoService;

@RequestMapping("/condomanage/*")
public class CondoController {//콘도 매니지컨트롤러
	CondoService serivce;
	
	@GetMapping("list")
	public void list(Model model) {
		
	}
	
	@PostMapping("modify")
	public void modify(CondoVO cmvo, RedirectAttributes rttr) {
		
	}
}
