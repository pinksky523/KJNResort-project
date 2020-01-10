package com.kjnresort.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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

import com.kjnresort.domain.BoardAttachVO;
import com.kjnresort.domain.BoardVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	@PreAuthorize("principal.username == #writer")						// 작성자 확인
	@PostMapping("remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("BoardController remove() " + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			// 첨부파일이 있는 경우 파일 삭제 메서드 호출
			if(attachList != null || attachList.size() > 0) {
				deleteFiles(attachList);
			}
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListlink();
	}
	
	//	첨부파일 삭제
	private void deleteFiles(List<BoardAttachVO> attachList) {
		log.info("delete files!");
		attachList.forEach(avo -> {
			try {
				Path file = Paths.get("C:\\upload\\"+ 
								avo.getUploadPath() +"\\" +
								avo.getUuid() + "_" +
								avo.getFileName());
				Files.deleteIfExists(file);								// 원본 파일 삭제
				if(Files.probeContentType(file).startsWith("image")) {	// 이미지의 경우
					Path thumbnail = Paths.get("C:\\upload\\"+ 
									avo.getUploadPath() +"\\s_" +
									avo.getUuid() + "_" +
									avo.getFileName());
					Files.deleteIfExists(thumbnail);					// 썸네일 삭제
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
	
	@PreAuthorize("principal.username == #board.writer")				// 작성자 확인
	@PostMapping("modify")
	public String modify(BoardVO board, RedirectAttributes rttr, 
		    			 @ModelAttribute("cri") Criteria cri) {
		log.info("BoardController modify()" + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListlink();
	}
	
//	@GetMapping("get")
	@GetMapping({"get", "modify"})
	public void get(Long bno, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("BoardController get() or modify()");
		model.addAttribute("board", service.get(bno));
	}

	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		log.info("BoardController list() with cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", 
							new PageDTO(cri, service.getTotalCount(cri)));
	}

	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("BoardController register() - get");
	}
	
	@PostMapping("register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("BoardController register()");
		log.info("register:" + board);
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("===============================");
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping(value = "getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList:" + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
		
	}
}













