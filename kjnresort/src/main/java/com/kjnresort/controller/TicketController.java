 package com.kjnresort.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	//이용권 외부 결제에서 결제완료 버튼 눌렀을때 (사용자)
	@PostMapping(value="buyTicket",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("isAuthenticated()")
	@Transactional
	public ResponseEntity<String> buyTicket(@RequestBody TicketBuyVO ticket, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri) {
		log.info("TicketController buyTicket() - post : " + ticket);
		log.info(ticket.getTicketNo());
		log.info(ticket.getToolAmount());
		log.info(ticket.getLiftAmount());
		log.info(ticket.getTotalPrice());
		int insertCount = service.register(ticket);
		long ticketNo = -1;
		if(insertCount == 1) {
			ticketNo = service.getMaxTicketNo();
		}
		
		return insertCount==1?new ResponseEntity<>(""+ticketNo,HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	 
	//이용권 구매 폼으로 이동 (사용자)
	@PreAuthorize("isAuthenticated()")
	@GetMapping("buyTicket")
	//@PreAuthorize("isAuthenticated()")
	public void buyTicket(Model model, Criteria cri) {
		log.info("TicketController buy() - get");
		model.addAttribute("tPrice", service.getPrice());
		model.addAttribute("ttPrice", service.getPriceT());
		log.info("getPrice()--------------");
	}

//	
//	  //이용권 구매에서 다음 버튼 눌렀을때 (사용자)
//	  
//	  @PostMapping("buyTicket") //@PreAuthorize("isAuthenticated()") public String
//	  buyTicket(TicketBuyVO ticket, Model model, RedirectAttributes rttr) {
//	  log.info("TicketController buyTicket() - Post" + ticket); return
//	  "redirect:/ticket/buyTicketResult"; }
//	 
	//이용권 구매 결과 페이지 (사용자)
	@GetMapping("buyTicketResult/{ticketNo}")
	//@PreAuthorize("isAuthenticated()")
	public String buyTicketResult(@PathVariable Long ticketNo, Model model) {
		log.info("TicketController result() - get");
		model.addAttribute("ticket", service.get(service.getMaxTicketNo()));
		return "ticket/buyTicketResult";
	}
	
	//이용권 상태변경 구매취소 (관리자)
	//@PreAuthorize("principal.username == #writer")	// 작성자 확인
	@PostMapping("cancel")
	public String cancel(Long ticketNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri, Principal principal) {
		log.info("TicketController cancel() " + ticketNo);
		service.modifyStatus(ticketNo);
		if(principal.getName().equals("admin")) {
			return "redirect:/ticket/buyTicketList" + cri.getListlink();
		}else {
			return "redirect:/ticket/buyTicketListUser" + cri.getListlink();
		}
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
	@PreAuthorize("isAuthenticated()")
	@GetMapping("buyTicketListUser") 
	public void buyTicketListUser(Criteria cri, String id, Model model, Principal principal) {
		log.info("TicketController buyTicketListUser() with cri : " + cri);
		log.info("TicketController buyTicketListUser() list : ");
		log.info(principal.getName());
		model.addAttribute("list", service.getListUser(principal.getName()));
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