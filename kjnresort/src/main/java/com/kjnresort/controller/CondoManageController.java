package com.kjnresort.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoManageVO;

import com.kjnresort.domain.Criteria;

@RequestMapping("/condo")
public class CondoManageController {
	
	@GetMapping("/list")
	public void condoList(Criteria cri,Model model) {
		
	}
	
	@PostMapping("/modify")
	public String condoModify(CondoManageVO cvo,RedirectAttributes rttr,Criteria cri) {
		return null;
	}
}
