package com.kjnresort.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaCriteria;
import com.kjnresort.domain.QnaVO;
import com.kjnresort.service.QnaService;

@RequestMapping("/qna")
public class QnaController {//큐엔에이컨트롤러
	QnaService service;
	
	@GetMapping("/list")
	public void list(QnaCriteria qnaCri, Model model,Principal principal) {
		
	}
	
	@PostMapping("/register")
	public String register(QnaVO qvo,RedirectAttributes rttr) {
		return null;
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping({"/get","/modify"})
	public QnaVO get(Long qno,Model model,QnaCriteria qnaCri) {
		return null;
	}
	
	
	@PostMapping("/modify")
	public String modify(QnaVO qvo,RedirectAttributes rttr, QnaCriteria qnaCri,String id) {
		return null;
	}
	

	@DeleteMapping
	public String remove(long qno,RedirectAttributes rttr,QnaCriteria qnaCri,String id) {
		return null;
	}
}
