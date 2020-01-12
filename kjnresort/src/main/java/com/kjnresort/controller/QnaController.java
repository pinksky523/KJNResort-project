package com.kjnresort.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;

@RequestMapping("/qna")
public class QnaController {

	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
	}
	
	@PostMapping("/register")
	public void register(QnaVO qvo,RedirectAttributes rttr) {
		
	}
	
	@PostMapping("/modify")
	public String modify(QnaVO qvo,RedirectAttributes rttr, Criteria cri) {
		return null;
	}
	
	@PostMapping("/remove")
	public String remove(long qno,RedirectAttributes rttr,Criteria cri) {
		return null;
	}
}
