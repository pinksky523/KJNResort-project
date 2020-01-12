package com.kjnresort.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kjnresort.domain.QnaReplyVO;

@RequestMapping("/qnareplies/")
public class QnaReaplyController {

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
