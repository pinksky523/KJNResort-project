package com.kjnresort.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.RecruitVO;
import com.kjnresort.service.RecruitService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//Controller - Service - Mapper - Mapper.xml - MyBatis db
@Controller
@Log4j
@RequestMapping("/recruit/*")
@AllArgsConstructor
public class RecruitController {
	private RecruitService service;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("recruitNo") Long recruitNo, RedirectAttributes rttr) {
		log.info("RecruitController remove()... " + recruitNo);
		if(service.remove(recruitNo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/recruit/list";
	}
	
	@PostMapping("/modify")
	public String modify(RecruitVO recruit, RedirectAttributes rttr) {
		log.info("RecruitController modify()");
		if(service.modify(recruit)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/recruit/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("recruitNo") Long recruitNo, Model model) {
		log.info("RecruitController get()");
		model.addAttribute("recruit", service.get(recruitNo));
	}
	
	@PostMapping("/register")
	public String register(RecruitVO recruit, RedirectAttributes rttr) {
		log.info("RecruitController register()");
		service.register(recruit);
		rttr.addFlashAttribute("result", recruit.getRecruitNo());		// 등록된 게시글의 RecruitNo를 result값에 담아서 redirect로 넘겨준다.
		return "redirect:/recruit/list";
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}
}
