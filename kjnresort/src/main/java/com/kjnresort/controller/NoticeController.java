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
		log.info("공지사항 등록창 진입");
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("noticeNo") Long noticeNo,  @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("공지사항 게시글 삭제 : " + noticeNo);
		if(service.remove(noticeNo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice/list" + cri.getListlink();
	}
	
	@PostMapping("/modify")
	public String modify(NoticeVO notice, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("공지사항 게시글 수정 완료");
		if(service.modify(notice)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice/list" + cri.getListlink();
	}
	
	@GetMapping({"/get","/modify"})
	public void get( Long noticeNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("NoticeController get()");
		model.addAttribute("notice", service.get(noticeNo));
	}
	
	@PostMapping("register")
	public String register(NoticeVO notice, RedirectAttributes rttr) {
		log.info("공지사항 게시글 등록 완료");
		service.register(notice);
		rttr.addFlashAttribute("result", notice.getNoticeNo());		// 등록된 게시글의 noticeNo를 result값에 담아서 redirect로 넘겨준다.
		return "redirect:/notice/list";
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotalCount(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
}
