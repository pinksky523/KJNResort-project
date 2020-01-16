package com.kjnresort.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@PostMapping("/customLogout")
	public void logoutPOST() {
		log.info("custom logout post");
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout get");
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("conmmonController accessDenied() : " + auth);
		model.addAttribute("msg", "접근 권한 없음");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		log.info("1111");
		
		if(error != null) {
			model.addAttribute("error", "Login Error! Check Your Account!!");
		}
		
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!!");
		}
	}
}
