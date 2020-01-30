package com.kjnresort.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.EventService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j

@RequestMapping("/event/*")
@AllArgsConstructor
public class EventController {
	private EventService service;
	
	
	
	//이벤트 게시글 등록화면
	@GetMapping("register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void register() {
		log.info("이벤트 게시글 등록화면 진입");
	}
	
	
	//이벤트 게시글 등록기능
	@PostMapping("register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(EventVO event, RedirectAttributes rttr, Principal principal) {
		event.setId(principal.getName());		//현재 로그인한 id(admin)을 이벤트 게시글 작성자로 셋팅
		
		event.getAttachList().get(0).setFileName("thumb." + event.getAttachList().get(0).getFileName());	//썸네일용은 앞에 thumb.
		if(event.getAttachList() != null) {
			event.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(event);
		rttr.addFlashAttribute("result", event.getEventNo());
		return "redirect:/event/list";
	}
	
	
	
	//이벤트 게시글 목록
	@GetMapping("list")
	public void list(Criteria cri, Model model) {

		cri = new Criteria(cri.getPageNum(),9);		//이벤트게시판은 9개씩
		
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	
	//이벤트 게시글 상세조회
	@GetMapping("get/{eventNo}")
	public String get(@PathVariable("eventNo") Long eventNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("1");
		service.updateViewCnt(eventNo);
		
		model.addAttribute("event", service.get(eventNo));
		
		
		return "/event/get";
	}
	
	//이벤트 게시글 수정 창
	@GetMapping("modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void modify(Long eventNo, Model model, @ModelAttribute("cri") Criteria cri) {
		
		model.addAttribute("event", service.get(eventNo));
	}
		
	
	
	//첨부파일리스트
	@GetMapping(value= "getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<EventAttachVO>> getAttachList(Long eventNo) {
		log.info("첨부파일 목록화면 진입");
		return new ResponseEntity<>(service.getAttachList(eventNo), HttpStatus.OK);
	}
			
		
	//이벤트 게시글 수정	
	@PostMapping("modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(EventVO event, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		event.getAttachList().get(0).setFileName("thumb." + event.getAttachList().get(0).getFileName());	//썸네일용은 앞에 thumb.
		if(service.modify(event)) {
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다");
		}
		
		return "redirect:/event/list" + cri.getListlink();
	}
	
	//이벤트 게시글 삭제
	@PostMapping("remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("eventNo") Long eventNo, String id, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		
		List<EventAttachVO> attachList = service.getAttachList(eventNo);
		
		if(service.remove(eventNo)) {
			//첨부 파일이 있는 경우 파일 삭제 메서드 호출
			if(attachList != null || attachList.size() > 0) {
				deleteFiles(attachList);
			}
			
			rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다");
		}
		
		return "redirect:/event/list" + cri.getListlink();
	}
	
	
	//첨부파일 삭제
	@PreAuthorize("isAuthenticated()")
	private void deleteFiles(List<EventAttachVO> attachList) {
		attachList.forEach(avo -> {
			
			try {
				Path file = Paths.get("c:\\upload\\" +
									avo.getUploadPath() + "\\" +
									avo.getUuid() + "_" +
									avo.getFileName());	//원본파일 삭제 	//uri를 받으면 Path 객체를 넘긴다
				Files.deleteIfExists(file);
				
				//이미지의 경우
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get("c:\\upload\\" +
							avo.getUploadPath() + "\\s_" +
							avo.getUuid() + "_" +
							avo.getFileName());	
					Files.delete(thumbnail);	//섬네일 삭제
				}
						
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
	
	
}
