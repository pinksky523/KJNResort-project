package com.kjnresort.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoVO;


import com.kjnresort.service.CondoService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RestController
@Log4j
@RequestMapping("/condomanage/*")
@AllArgsConstructor
public class CondoController {//콘도 매니지컨트롤러
	private CondoService service;
	
	@GetMapping(value="/{roomType}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CondoVO> get(@PathVariable("roomType") String roomType){
		log.info("get CondoVO Controller..."+roomType);
		log.info("하 결과출력.."+service.get(roomType));
		return new ResponseEntity<>(service.get(roomType),HttpStatus.OK);
	}
	
	
	@GetMapping("list")
	public void list(Model model) {
		
	}
	
	@PostMapping("modify")
	public void modify(CondoVO cmvo, RedirectAttributes rttr) {
		
	}
}
