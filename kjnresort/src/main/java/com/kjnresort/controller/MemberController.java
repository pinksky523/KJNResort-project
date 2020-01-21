package com.kjnresort.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.MemberVO;
import com.kjnresort.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	
	
		
	@GetMapping("mypage")
	public void mypageGet(MemberVO member, Model model) {
		log.info("마이페이지 창 진입");
		log.info("마이페이지 값체크 : " + service.mypageGet(member));
		model.addAttribute("member", service.mypageGet(member));
	}
}
