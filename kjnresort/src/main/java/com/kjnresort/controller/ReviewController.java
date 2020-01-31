package com.kjnresort.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.apache.ibatis.annotations.Param;
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

import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.domain.ReviewVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.ReplyService;
import com.kjnresort.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.GetProxy;

@Controller
@Log4j
@RequestMapping("/review/*")
@AllArgsConstructor
public class ReviewController {
	private ReviewService service;
	private ReplyService replyService;
	
 	//후기 삭제
	@PreAuthorize("principal.username == #id")						// 작성자 확인
	@PostMapping("remove")
	public String remove(@RequestParam("reviewNo") Long reviewNo, RedirectAttributes rttr, 
			 @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("reviewController remove() " + reviewNo);
		service.remove(reviewNo);
//		List<ReviewAttachVO> attachList = service.getAttachList(reviewNo);
//		if(service.remove(reviewNo)) {
//			// 첨부파일이 있는 경우 파일 삭제 메서드 호출
//			if(attachList != null || attachList.size() > 0) {
//				deleteFiles(attachList);
//			}
//			rttr.addFlashAttribute("result", "success");
//		}
		return "redirect:/review/list" + cri.getListlink();
	}
	
	//	첨부파일 삭제
	private void deleteFiles(List<ReviewAttachVO> attachList) {
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
	
	//후기 수정
	@PreAuthorize("principal.username == #review.id")				// 작성자 확인
	@PostMapping("modify")
	public String modify(ReviewVO review, RedirectAttributes rttr, 
		    			 @ModelAttribute("cri") Criteria cri) {
		log.info("ReviewController modify()" + review);
		service.modify(review);
		return "redirect:/review/list" + cri.getListlink();
	}
	
	//후기 상세보기
	@GetMapping({"get", "modify"})
	public void get(Long reviewNo, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("ReviewController get() or modify()");
		model.addAttribute("review", service.get(reviewNo));
		
	}
	
	//후기 리스트
	@PreAuthorize("isAuthenticated()")
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		log.info("ReviewController list() with cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", 
							new PageDTO(cri, service.getTotalCount(cri)));
	}
	
	
	//내가 쓴 후기 리스트
	@PostMapping("myreviewList")
	public String myreviewList(@Param("id") String id, Criteria cri, Model model) {
		int pageNum = cri.getPageNum();
		int amount = cri.getAmount();
		model.addAttribute("list", service.getMyList(id, pageNum, amount));
		model.addAttribute("pageMaker", 
							new PageDTO(cri, service.getMyTotalCount(id, pageNum, amount)));
		
		return "redirect:/review/list";
	}
	
	//후기 등록 폼으로 가는 버튼 클릭
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register(@Param("ticketNo") Long ticketNo,@Param("reserveNo") Long reserveNo ,Model model) {
		log.info("ReviewController register() - get");
		log.info("ticketNo : " + ticketNo);
		if(ticketNo != null) {
			model.addAttribute("useNo", ticketNo);
		} else {
			model.addAttribute("useNo", reserveNo);
		}
		
		
	}
	
	//후기 등록 버튼 클릭
	@PostMapping("register")
	@PreAuthorize("isAuthenticated()")
	public String register(ReviewVO review, Long ticketNo, RedirectAttributes rttr, Model model) {
		log.info("ReviewController register()");
		log.info("register:" + review);
		if(review.getAttachList() != null) {
			review.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("===============================");
		log.info("modifyTReview ticketNo : " + ticketNo);
		service.register(review);
		service.modifyTReview(ticketNo);
		rttr.addFlashAttribute("result", review.getReviewNo());
		return "redirect:/review/list";
	}
	
	//첨부파일 리스트  , produces = MediaType.APPLICATION_JSON_UTF8_VALUE
	@GetMapping("getAttachList")
	@ResponseBody
	public ResponseEntity<List<ReviewAttachVO>> getAttachList(Long reviewNo){
		log.info("-----------------------------------------------");
		log.info("getAttachList : " + reviewNo);
		return new ResponseEntity<>(service.getAttachList(reviewNo), HttpStatus.OK);
		
	}
}
