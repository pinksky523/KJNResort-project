package com.kjnresort.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.NoticeVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//Controller - Service - Mapper - Mapper.xml - MyBatis db
@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	private NoticeService service;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping("/modify")
	public void modify() {
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("noticeNo") Long noticeNo,  @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("NoticeController remove()... " + noticeNo);
		if(service.remove(noticeNo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice/list" + cri.getListlink();
	}
	
	@PostMapping("/modify")
	public String modify(NoticeVO notice, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("NoticeController modify()");
		if(service.modify(notice)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/notice/list" + cri.getListlink();
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("noticeNo") Long noticeNo, 
					Model model, 
					@ModelAttribute("cri") Criteria cri) {
		log.info("NoticeController get()");
		model.addAttribute("notice", service.get(noticeNo));
	}
	
	// /board/register POST 요청을 처리하는 register() 작성
	// 파라미터는 등록된 게시물의 정보를 갖는 BoardVO 객체와
	// /board/list로 리다이렉트하기 위한 RedirectAttributes 객체를 받음
	// 기능 : 파라미터로 받은 BoardVO 객체를 tbl_board 테이블에 저장하고
	//		등록된 게시물의 번호를 result 속성에 담아
	//		/board/list로 리다이렉트
	
	@PostMapping("register")
	public String register(NoticeVO notice, RedirectAttributes rttr) {
		log.info("NoticeController register()");
		service.register(notice);
		rttr.addFlashAttribute("result", notice.getNoticeNo());		// 등록된 게시글의 bno를 result값에 담아서 redirect로 넘겨준다.
		return "redirect:/notice/list";
	}
	
	// /board/list GET 요청을 처리하는 list() 작성
	// 결과 뷰로 tbl_board 테이블의 전체 목록을 담아 가도록 처리
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("BoardController list()");
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
	//	model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotalCount(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
}
