package com.kjnresort.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kjnresort.domain.QnaReplyVO;
import com.kjnresort.service.QnaReplyService;

@RequestMapping("/qnareply/")
<<<<<<< HEAD
public class QnaReplyController {
=======
public class QnaReplyController {//큐엔에이 리플라이 컨트롤러
>>>>>>> branch 'master' of https://github.com/jsnow0819/Project.git
    QnaReplyService service;
	@GetMapping("/get")
	public ResponseEntity<QnaReplyVO> get(Long qno){
		return null;
	}
	
	@PostMapping(value = "new",
			 consumes = "application/json",
			 produces = MediaType.TEXT_PLAIN_VALUE)
	public  ResponseEntity<String> register(@RequestBody QnaReplyVO qRVO){
		return null;
	}
	
	@DeleteMapping(value = "{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(Long qno){
		return null;
	}
}
