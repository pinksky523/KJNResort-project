 package com.kjnresort.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.kjnresort.domain.PageDTO;

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
	
	//이용권 외부 결제 폼으로 이동 (사용자) 현재필요없음
//	@GetMapping("buyTicketKakao")
//	p@PreAuthorize("isAuthenticated()")
//	public void buyTicketKakao(Model model, HttpServletRequest request) {
//		 int liftAmount = Integer.parseInt(request.getParameter("liftAmount")); 
//		 int toolAmount = Integer.parseInt(request.getParameter("toolAmount"));
//		 request.setAttribute("liftAmount", liftAmount);
//		 request.setAttribute("toolAmount", toolAmount); 
//		 model.addAttribute("tPrice", service.getPrice());
//		 model.addAttribute("ttPrice", service.getPriceT());
//		log.info("TicketController buyTicketKakao() - get!!");
//	}
	
	//이용권 외부 결제에서 결제완료 버튼 눌렀을때 (사용자)
	@PostMapping("buyTicketKakao")
	//@PreAuthorize("isAuthenticated()")
	public String buyTicketKakao(TicketBuyVO ticket, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController buyTicketKakao() - post" + ticket);
		return "redirect:/ticket/buyTicket";
	}
	 
	//이용권 구매 폼으로 이동 (사용자)
	@GetMapping("buyTicket")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicket(Model model, Criteria cri) {
		log.info("TicketController buy() - get");
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("getPrice()--------------");
	}
	
	//이용권 구매에서 다음 버튼 눌렀을때 (사용자)
	@PostMapping("buyTicket")
	//@PreAuthorize("isAuthenticated()")
	public String buyTicket(TicketBuyVO ticket, Model model, RedirectAttributes rttr) {
		log.info("TicketController buyTicket() - Post" + ticket);
		return "redirect:/ticket/buyTicketResult";
	}
	
	//이용권 구매 결과 페이지 (사용자)
	@GetMapping("buyTicketResult")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicketResult(Long ticketNo, Model model) {
		log.info("TicketController result() - get");
		//model.addAttribute("ticket", service.get(ticketNo));
	}
	
	//이용권 상태변경 구매취소 (관리자)
	//@PreAuthorize("principal.username == #writer")	// 작성자 확인
	@PostMapping("cancel")
	public String cancel(Long ticketNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController cancel() " + ticketNo);
		service.modifyStatus(ticketNo);
		return "redirect:/ticket/buyTicketList" + cri.getListlink();
	}
	
	//이용권 상태변경 이용확인 (관리자)
	@PostMapping("use")
	public String use(Long ticketNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController use() " + ticketNo);
		service.modifyStatusUse(ticketNo);
		return "redirect:/ticket/buyTicketList" + cri.getListlink();
	}
	
	//이용권 가격 수정 (관리자)
	//@PreAuthorize("principal.username == #board.writer")				// 작성자 확인
	@PostMapping("modify")
	public String modify(TicketVO tPrice, TicketVO ttPrice, RedirectAttributes rttr) {
		log.info("TicketController modify() price" + tPrice);
		service.modify(tPrice);
		return "redirect:/ticket/modify";
	}
	
	//이용권 가격 수정 폼으로 (관리자)
	@GetMapping("modify")
	public void get(Model model) {
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("TicketController modify()");
	}
	
	// 이용권 구매 상세보기 (사용자)
	@GetMapping(value = {"buyTicketGetUser/{ticketNo}/{id}"})
	public String buyTicketGetUser(@PathVariable("ticketNo") Long ticketNo, @PathVariable("id") String id, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController buyTicketGet()----------------");
		log.info("id : " + id);
		log.info("no : " + ticketNo);
		model.addAttribute("ticket", service.get(ticketNo));
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		model.addAttribute("member", service.getMember(id));
		return "ticket/buyTicketGetUser";
	}
	
	//이용권 구매 목록 (사용자)
	@PostMapping("buyTicketListUser") 
	public void buyTicketListUser(Criteria cri, String id, Model model) {
		log.info("TicketController buyTicketListUser() with cri : " + cri);
		log.info("TicketController buyTicketListUser() list : ");
		model.addAttribute("list", service.getListUser(id));
		/*
		 * model.addAttribute("pageMaker", new PageDTO(cri,
		 * service.getTotalCount(cri)));
		 */
	}
	
	// 이용권 구매 상세보기 (관리자)
	@GetMapping(value = {"buyTicketGet/{ticketNo}/{id}"})
	public String buyTicketGet(@PathVariable("ticketNo") Long ticketNo, @PathVariable("id") String id, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController buyTicketGet()----------------");
		log.info("id : " + id);
		log.info("no : " + ticketNo);
		model.addAttribute("ticket", service.get(ticketNo));
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		model.addAttribute("member", service.getMember(id));
		return "ticket/buyTicketGet";
	}
	
	//이용권 구매 목록 (관리자)
	@GetMapping("buyTicketList") 
	public void buyTicketList(Criteria cri, String id, Model model) {
		log.info("TicketController list() with cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", 
							new PageDTO(cri, service.getTotalCount(cri)));
	}

}