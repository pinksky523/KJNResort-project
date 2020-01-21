package com.kjnresort.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.ApplianceService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//Controller - Service - Mapper - Mapper.xml - MyBatis db
@Controller
@Log4j
@RequestMapping("/appliance/*")
@AllArgsConstructor
public class ApplianceController {
	private ApplianceService service;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("id") String id, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("ApplianceController get()");
		model.addAttribute("appliance", service.get(id));
	}
	
	@PostMapping("/register")
	public String register(ApplianceVO appliance, RedirectAttributes rttr) {
		log.info("ApplianceController register()");
		service.register(appliance);
		rttr.addFlashAttribute("result", appliance.getRecruitNo());		// 등록된 게시글의 recruitNo를 result값에 담아서 redirect로 넘겨준다.
		return "redirect:/appliance/list";
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotalCount(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PostMapping("/save")
	public String applianceSave(ApplianceVO appliance, RedirectAttributes rttr) {
		return null;
	}
}
