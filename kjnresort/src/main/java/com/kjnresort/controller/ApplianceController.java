package com.kjnresort.controller;

import org.springframework.security.access.prepost.PreAuthorize;
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
import com.kjnresort.domain.MemberVO;
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
	public void register(MemberVO member, Long recruitNo, Model model) {
		log.info("지원서 등록창 진입");
		model.addAttribute("member", service.memberGet(member));
		model.addAttribute("recruit", service.recruitGet(recruitNo));
	}
	
	@PostMapping("/register")
	public String register(ApplianceVO appliance, RedirectAttributes rttr) {
		service.register(appliance);
		log.info("지원서 등록");
		rttr.addFlashAttribute("result", appliance.getRecruitNo());		// 등록된 게시글의 recruitNo를 result값에 담아서 redirect로 넘겨준다.
		return "redirect:/appliance/myList";
	}
	
	@PostMapping("/save")
	public String applianceSave(ApplianceVO appliance, RedirectAttributes rttr) {
		log.info("지원서 임시저장");
		return null;
	}
	
	@PreAuthorize("principal.username == #appliance.id")
	@GetMapping("/myList")												// 나의 지원내역 리스트(사용자)
	public void list(Model model) {
		log.info("나의 지원내역 조회");
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/get")													// 지원서 상세조회(관리자)
	public void get(@RequestParam("applianceNo") Long applianceNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("지원서 상세조회");
		model.addAttribute("appliance", service.get(applianceNo));
	}
	
	@GetMapping("/list")										// 전체 지원내역 리스트(관리자)
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotalCount(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
}
