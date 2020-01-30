package com.kjnresort.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.domain.QnaVO;

import com.kjnresort.service.QnaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@RequestMapping("/qna/*")
@AllArgsConstructor
@Controller
public class QnaController {//큐엔에이컨트롤러
	private QnaService service;
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Criteria cri, Model model,Principal principal) {
		log.info(principal.getName());
		if(principal.getName().equals("admin")) {
			log.info("문의 목록 컨트롤러 관리자입니다.");
			int total=service.getTotalCount(cri);
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			model.addAttribute("list",service.getListWithPaging(cri));
		}else {
			log.info("문의목록 컨트롤러 "+principal.getName()+"입니다.");
			int total=service.getTotalCountWithId(cri,principal.getName());
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			model.addAttribute("list", service.getListWithId(cri,principal.getName()));
		}
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/register")
	public String register(QnaVO qvo,RedirectAttributes rttr) {
		log.info("qnacontroller.... /register[post]");
		log.info(qvo.getId());
		log.info(qvo.getCategory());
		log.info(qvo.getTitle());
		log.info(qvo.getContent());
		service.register(qvo);
		rttr.addFlashAttribute("result", "regiSuccess");
		return "redirect:/qna/list";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/register")
	public void register() {
		log.info("qnacontroller.... /register[get]");
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/get","/modify"})
	public void get(Long qno,Model model,Criteria cri) {
		log.info(qno.getClass());
		log.info("QnaController GetMapping-get/modify");
		model.addAttribute("qna", service.get(qno));
		model.addAttribute("cri", cri);
	}
	
	
	@PreAuthorize("principal.username==#qvo.id") //작성자확인
	@PostMapping("/modify")
	public String modify(QnaVO qvo,RedirectAttributes rttr, Criteria cri) {
		log.info("QnaController PostMapping-modify");
		if(service.modify(qvo)) {
			log.info("qna 수정 성공");
			rttr.addFlashAttribute("result", "modiSuccess");
		}
		return "redirect:/qna/list"+cri.getListlink();
		
	}
	
	@PreAuthorize("principal.username==#id") //작성자확인
	@PostMapping("/remove")
	public String remove(long qno,RedirectAttributes rttr,Criteria cri,String id) {
		log.info("QnaController PostMapping-remove");
		if(service.remove(qno)) {
			log.info("qna 삭제 성공");
			rttr.addFlashAttribute("result", "delSuccess");
		}
		return "redirect:/qna/list"+cri.getListlink();
	}
	
	@ResponseBody
	@PreAuthorize("principal.username==#id") 
	@PostMapping(value="/registerAnswer",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> registerAnswer(long qno,String answer,String id) {
		log.info("qna controller......registerAnswer"+answer);
		log.info("qna controller......registerAnswer"+qno);
		log.info("qna controller......registerAnswer"+id);
		return service.registerAnswer(qno,answer)==true?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PreAuthorize("principal.username==#id") 
	@PostMapping(value="/deleteAnswer",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> deleteAnswer(long qno,String id) {
		log.info("qna controller......deleteAnswer"+qno);
		log.info("qna controller......deleteAnswer"+id);
		return service.deleteAnswer(qno)==true?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
