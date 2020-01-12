package com.kjnresort.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@GetMapping("getAttachList")
	@ResponseBody
	public ResponseEntity<List<EventAttachVO>> getAttachList(Long eventNo) {
		
		return new ResponseEntity<>(service.getAttachList(eventNo), HttpStatus.OK);
	}
	
	@GetMapping("list")
	public void list(Criteria cri, Model model) {

		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	

	//2페이지의 게시글을 조회한 뒤 list 누르면 다시 2페이지로 가게 하기
	//2페이지의 게시글을 조회하고 수정 화면에서 list 누르면 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	//pageNum, amount 추가	
	//@RequestParam은 안써도 됨
	//@ModelAttribute를 안쓰면 화면 전환될 때 에러 발생
	@GetMapping({"get", "modify"})
	public void get(Long eventNo, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("event", service.get(eventNo));
	}
	
	
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register() {

	}
	
	//2페이지의 게시글을 조회하고 수정 화면에서 remove 누르면 삭제 후 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	@PreAuthorize("principal.username == #writer")
	@PostMapping("remove")
	public String remove(@RequestParam("eventNo") Long eventNo, RedirectAttributes rttr, 
						@ModelAttribute("cri") Criteria cri, String writer) {
		
		List<EventAttachVO> attachList = service.getAttachList(eventNo);
		
		
		if(service.remove(eventNo)) {
			//첨부파일이 있는 경우 파일 삭제 메서드 호출
			if(attachList != null || attachList.size() > 0) {
				deleteFiles(attachList);
			}
			
			rttr.addFlashAttribute("result", "삭제");
		}
		
		//Criteria에서 getListLink()를 만들어주었기 때문에 아래 코드를 주석으로 처리함
//		//redirect로 보내기 때문에 이것을 써줘야 함
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		
//		//검색 후 다시 해당 페이지로 이동
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/event/list";
		
		return "redirect:/event/list" + cri.getListlink();
	}
	
	//첨부파일 삭제
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
	

	//2페이지의 게시글을 조회하고 수정 화면에서 list 누르면 수정 후 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	@PreAuthorize("principal.username == #event.writer")
	@PostMapping("modify")
	public String modify(EventVO event, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {

		if(service.modify(event)) {
			rttr.addFlashAttribute("result", "수정");
		}
		
		//Criteria에서 getListLink()를 만들어주었기 때문에 아래 코드를 주석으로 처리함
//		//redirect로 보내기 때문에 이것을 써줘야 함
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		
//		//검색 후 다시 해당 페이지로 이동
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//				
//		return "redirect:/board/list";
		
		return "redirect:/event/list" + cri.getListlink();
	}
	
//	@GetMapping("get")
//	public void get(@RequestParam("bno") Long bno, Model model) {
//		log.info("BoardController get()");
//		model.addAttribute("board", service.get(bno));
//	}
	
	// /board/register POST 요청을 처리하는 register() 작성
	// 파라미터는 등록된 게시물의 정보를 갖는 BoardVO 객체와
	// /board/list로 리다이렉트하기 위한 RedirectAttributes 객체를 받음
	// 기능 : 파라미터로 받은 BoardVO 객체를 tbl_board 테이블에 저장하고
	//		등록된 게시물의 번호를 result 속성에 담아
	//		/board/list로 리다이렉트
	@PostMapping("register")
	@PreAuthorize("isAuthenticated()")
	public String register(EventVO event, RedirectAttributes rttr) {

		if(event.getAttachList() != null) {
			event.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(event);
		rttr.addFlashAttribute("result", event.getEventNo());
		return "redirect:/event/list";
	}
	
	// /board/list GET 요청을 처리하는 list() 작성
	// 결과 뷰로 tbl_board 테이블의 전체 목록을 담아 가도록 처리
//	@GetMapping("list")
//	public void list(Model model) {
//		log.info("BoardController list()");
//		model.addAttribute("list", service.getList());
//	}
}
