 package com.kjnresort.controller;

import javax.servlet.http.HttpServletRequest;
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
import com.kjnresort.domain.TicketVO;
import com.kjnresort.service.TicketService;
import com.kjnresort.domain.Criteria;
//import com.kjnresort.service.TicketService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/ticket/*")
@AllArgsConstructor
public class TicketController {
	private TicketService service;
	
	//이용권 외부 결제 폼으로 이동
	@GetMapping("buyTicketKakao")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicketKakao(Model model, HttpServletRequest request) {
		int liftAmount = Integer.parseInt(request.getParameter("liftAmount"));
		int toolAmount = Integer.parseInt(request.getParameter("toolAmount"));
		request.setAttribute("liftAmount", liftAmount);
		request.setAttribute("toolAmount", toolAmount);
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("TicketController buyTicketKakao() - get!!!!!!!!~~~~!!!!!");
	}
	
	//이용권 외부 결제에서 결제완료 버튼 눌렀을때
	@PostMapping("buyTicketKakao")
	//@PreAuthorize("isAuthenticated()")
	public String buyTicketKakao(TicketBuyVO ticket, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController buyTicketKakao() - post" + ticket);
		return "redirect:/ticket/buyTicket";
	}
	
	//이용권 구매 폼으로 이동
	@GetMapping("buyTicket")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicket(Model model, Criteria cri) {
		log.info("TicketController buy() - get");
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("getPrice()--------------");
	}
	
	//이용권 구매에서 다음 버튼 눌렀을때
	@PostMapping("buyTicket")
	//@PreAuthorize("isAuthenticated()")
	public String buyTicket(TicketBuyVO ticket, Model model, RedirectAttributes rttr) {
		log.info("TicketController buyTicket() - Post" + ticket);
		
		return "redirect:/ticket/buyTicketResult";
	}
	
	//이용권 구매 결과 페이지
	@GetMapping("buyTicketResult")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicketResult(Long ticketNo, Model model) {
		log.info("TicketController result() - get");
		//model.addAttribute("ticket", service.get(ticketNo));
	}
	
	
	//이용권 구매 취소 이건 업데이트로 바꿔야함
	//@PreAuthorize("principal.username == #writer")						// 작성자 확인
	@PostMapping("cancel")
	public String cancel(@RequestParam("ticketNo") Long ticketNo, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("TicketController remove() " + ticketNo);
		
		return "redirect:/ticket/list" + cri.getListlink();
	}
	
	//이용권 가격 수정
	//@PreAuthorize("principal.username == #board.writer")				// 작성자 확인
	@PostMapping("modify")
	public String modify(TicketVO tVO, RedirectAttributes rttr) {
		log.info("TicketController modify() price" + tVO);
		if(service.modify(tVO)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/adminMain";
	}
	
	//이용권 가격 수정 폼으로
	@GetMapping("modify")
	public void get(Model model) {
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("TicketController modify()");

	}
	
	//이용권 구매 내역 리스트
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		log.info("TicketController list() with cri : " + cri);
	}

}