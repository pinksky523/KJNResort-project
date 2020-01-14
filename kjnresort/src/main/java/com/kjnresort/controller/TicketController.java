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

import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.Criteria;
//import com.kjnresort.service.TicketService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/ticket/*")
@AllArgsConstructor
public class TicketController {
	//private TicketService service;
	
	@GetMapping("buyTicket")
	@PreAuthorize("isAuthenticated()")
	public void buyTicket() {
		log.info("TicketController register() - get");
	}
	
	@PostMapping("buyTicket")
	@PreAuthorize("isAuthenticated()")
	public String buyTicket(TicketBuyVO ticket, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController modify()" + ticket);
		return "redirect:/ticket/list" + cri.getListlink();
	}
	
	@GetMapping("buyTicketResult")
	@PreAuthorize("isAuthenticated()")
	public void buyTicketResult() {
		log.info("TicketController register() - get");
	}
	
//	//이용권 구매 폼으로 가는 버튼 클릭
//	@GetMapping("register")
//	@PreAuthorize("isAuthenticated()")
//	public void register() {
//		log.info("TicketController register() - get");
//	}
//	
//	//이용권 결제 버튼 클릭
//	@PostMapping("register")
//	@PreAuthorize("isAuthenticated()")
//	public String register(TicketVO ticket, RedirectAttributes rttr) {
//		log.info("TicketController register()");
//		return "redirect:/ticket/list";
//	}
	
	//이용권 구매 취소 이건 업데이트로 바꿔야함
	@PreAuthorize("principal.username == #writer")						// 작성자 확인
	@PostMapping("cancel")
	public String cancel(@RequestParam("ticketNo") Long ticketNo, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("BoardController remove() " + ticketNo);
		
		return "redirect:/ticket/list" + cri.getListlink();
	}
	
	//이용권 가격 수정
	@PreAuthorize("principal.username == #board.writer")				// 작성자 확인
	@PostMapping("modify")
	public String modify(TicketBuyVO ticket, RedirectAttributes rttr, 
		    			 @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController modify()" + ticket);
		return "redirect:/ticket/list" + cri.getListlink();
	}
	
	//이용권 가격 수정 폼으로
//	@GetMapping("get")
	@GetMapping({"get", "modify"})
	public void get(Long ticketNo, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController get() or modify()");

	}
	
	//이용권 구매 내역 리스트
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		log.info("TicketController list() with cri : " + cri);
	}

}