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
@RequestMapping("/check")
@AllArgsConstructor
public class joongBokCheckController {
	private MemberService service;
	
	
	//아이디 중복체크
	 @GetMapping(value="/idCheck/{id}", produces = {MediaType.APPLICATION_XML_VALUE,
	 MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<MemberVO>
	 getId(@PathVariable("id") String id){
		 log.info("idCheckController 진입");
		 log.info("값 체크 : " + service.idCheck(id));
	 return new ResponseEntity<>(service.idCheck(id), HttpStatus.OK); }
	 
	 
	 //핸드폰번호 중복체크
	 @GetMapping(value="/phoneCheck/{phoneNumber}", produces = {MediaType.APPLICATION_XML_VALUE,
			 MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<MemberVO>
			 getPhoneNumber(@PathVariable("phoneNumber") String phoneNumber){
				 log.info("phoneNumberCheckController 진입");
				 log.info("값 체크 : " + service.phoneNumberCheck(phoneNumber));
			 return new ResponseEntity<>(service.phoneNumberCheck(phoneNumber), HttpStatus.OK); }
	 
	 
	 
	 
}
