package com.kjnresort.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyPageDTO;
import com.kjnresort.domain.ReviewReplyVO;
import com.kjnresort.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReviewReplyController {
	private ReplyService service;
	
	@GetMapping(value = "pages/{reviewNo}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("reviewNo") Long reviewNo,
										  		 @PathVariable("page") int page) {
		log.info("ReplyController getList() reviewNo : " + reviewNo);
		log.info("ReplyController getList() page : " + page);
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(service.getListPage(cri, reviewNo), HttpStatus.OK);
	}	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "new",
				 consumes = "application/json",
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody ReviewReplyVO rvo) {
		log.info("ReviewReplyVO : " + rvo);
		return service.register(rvo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	@GetMapping(value = "{replyNo}")
	public ResponseEntity<ReviewReplyVO> get(@PathVariable("replyNo") Long replyNo) {
		log.info("ReplyController get() replyNo : " + replyNo);
		return new ResponseEntity<>(service.get(replyNo), HttpStatus.OK);
	}	
	
	@PreAuthorize("principal.username == #rvo.id")
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
				   	value = "{replyNo}",
				   	produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@PathVariable("replyNo") Long replyNo,
										 @RequestBody ReviewReplyVO rvo) {
		log.info("ReplyController modify() replyNo : " + replyNo);
		log.info("ReplyController modify() rvo : " + rvo);
		return service.modify(rvo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	@PreAuthorize("principal.username == #rvo.id")
	@DeleteMapping(value = "{replyNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@RequestBody ReviewReplyVO rvo, @PathVariable("replyNo") Long replyNo) {
		log.info("ReplyController remove() replyNo : " + replyNo);
		return service.remove(replyNo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
}













