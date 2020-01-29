package com.kjnresort.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjnresort.domain.CondoVO;


import com.kjnresort.service.CondoService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Log4j
@RequestMapping("/condomanage/*")
@AllArgsConstructor
@Controller
public class CondoController {//콘도 매니지컨트롤러
	private CondoService service;
	
	@ResponseBody
	@GetMapping(value="/{roomType}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CondoVO> get(@PathVariable("roomType") String roomType){
		log.info("get CondoVO Controller..."+roomType);
	
		return new ResponseEntity<>(service.get(roomType),HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Model model) {
		log.info("condo controller.........list()");
		model.addAttribute("list", service.getCondoList());
	}
	
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	@PostMapping(value="/modify",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(String roomType,int price) {
		log.info("condo controller...........modify()");
		log.info("roomType"+roomType);
		log.info("price"+price);
		
		return service.modify(roomType, price)==true?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
}
