package com.kjnresort.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("adminMain")
	public void adminMain() {
		log.info("관리자 메인화면 진입");
	}
	
	
}
