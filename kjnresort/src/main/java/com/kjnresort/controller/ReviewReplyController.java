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
	
	@GetMapping(value = "pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("bno") Long bno,
										  		 @PathVariable("page") int page) {
		log.info("ReplyController getList() bno : " + bno);
		log.info("ReplyController getList() page : " + page);
		Criteria cri = new Criteria(page, 10);
//		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "new",
				 consumes = "application/json",
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody ReviewReplyVO rvo) {
		log.info("ReplyVO : " + rvo);
		return service.register(rvo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	@GetMapping(value = "{rno}")
	public ResponseEntity<ReviewReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("ReplyController get() rno : " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}	
	
	@PreAuthorize("principal.username == #rvo.replyer")
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
				   	value = "{rno}",
				   	produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno,
										 @RequestBody ReviewReplyVO rvo) {
		log.info("ReplyController modify() rno : " + rno);
		log.info("ReplyController modify() rvo : " + rvo);
//		rvo.setRno(rno);
		return service.modify(rvo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	@PreAuthorize("principal.username == #rvo.replyer")
	@DeleteMapping(value = "{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@RequestBody ReviewReplyVO rvo, @PathVariable("rno") Long rno) {
		log.info("ReplyController remove() rno : " + rno);
		return service.remove(rno) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
}













