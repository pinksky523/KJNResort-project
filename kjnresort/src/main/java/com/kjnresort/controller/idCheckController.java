package com.kjnresort.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kjnresort.domain.MemberVO;
import com.kjnresort.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/idCheck")
@AllArgsConstructor
public class idCheckController {
	private MemberService service;
	
	 @GetMapping(value="/{id}", produces = {MediaType.APPLICATION_XML_VALUE,
	 MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<MemberVO>
	 get(@PathVariable("id") String id){
		 log.info("idCheckController 진입");
		 log.info("======================================================================");
		 log.info("값 체크 : " + service.idCheck(id));
	 return new ResponseEntity<>(service.idCheck(id), HttpStatus.OK); }
}
