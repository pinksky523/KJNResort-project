package com.kjnresort.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.service.CondoReserveService;
import com.kjnresort.service.CondoReserveServiceImpl;

import com.kjnresort.domain.PageDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@RequestMapping("/condoreserve/*")
@AllArgsConstructor
@Controller
public class CondoReserveController { //헐 이제 될거같아
	private CondoReserveService service;
	
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	//produces= {MediaType.TEXT_PLAIN_VALUE}
	//consumes = "application/json"
	@ResponseBody
	@RequestMapping(value="/availableRoomType",method = RequestMethod.POST,produces= {MediaType.APPLICATION_XML_VALUE,
			   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<String>> getAvailableRoomTypeList(@Param("checkIn") @DateTimeFormat(pattern="yyyy-MM-dd") Date checkIn,@Param("checkOut") @DateTimeFormat(pattern="yyyy-MM-dd") Date checkOut) {
		log.info("getAvailableRoomTypeList Controller 진입");
		Calendar in=Calendar.getInstance();
		in.setTime(checkIn);
		Calendar out=Calendar.getInstance();
		out.setTime(checkOut);
	
		return new ResponseEntity<>(service.getAvailableRoomType(in, out),HttpStatus.OK);
	}
	
	@ResponseBody
	@PreAuthorize("principal.username==#id||principal.username=='admin'")
	@PostMapping(value="/cancel",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> reserveCancel(Long reserveNo,String id) {
		log.info("condoreserve/cancel Controller........ reserveNo:"+reserveNo);
		log.info("condoreserve/cancel Controller........ id:"+id);
		return service.modify(reserveNo, -1)==true?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/register",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	@Transactional
	public ResponseEntity<String> register(@RequestBody CondoReserveVO crVO) {
		log.info("post /register 컨트롤러");
		log.info(crVO.getCheckIn());
		log.info(crVO.getCheckOut());
		log.info(crVO.getId());
		log.info(crVO.getPrice());
		log.info(crVO.getNights());
		log.info(crVO.getReserveDate());
		log.info(crVO.getRoomType());
		int insertCount=service.register(crVO);
		long reserveNo=-1;
		if(insertCount==1) {
			reserveNo=service.getMaxReserveNo();
		}
		return insertCount==1?new ResponseEntity<>(""+reserveNo,HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Model model,Criteria cri,Principal principal) {
		log.info(principal.getName());
		if(principal.getName().equals("admin")) {
			log.info("예약목록 리스트컨트롤러 관리자입니다.");
			int total=service.getTotalCount(cri);
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			model.addAttribute("list",service.getListWithPaging(cri));
		}else {
			log.info("예약목록 리스트컨트롤러 "+principal.getName()+"입니다.");
			int total=service.getTotalCountWithId(cri,principal.getName());
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			model.addAttribute("list", service.getListWithId(cri,principal.getName()));
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/get")
	public void get(Long rno,Model model,Criteria cri) {
		log.info("Condoreserve Controller Get.....");
		model.addAttribute("reserve", service.get(rno));
		model.addAttribute("cri", cri);
	}
	
	
	@ResponseBody
	@PreAuthorize("principal.username==#id")
	@PostMapping(value="/confirm",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> reserveConfirm(Long reserveNo,String id) {
		log.info("condoreserve/confirm Controller........ reserveNo:"+reserveNo);
		log.info("condoreserve/confirm Controller........ id:"+id);
		return service.modify(reserveNo,1)==true?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			
	}
	
	@GetMapping("/register")
	public void register() {
	
	}
	
	
	@GetMapping("/payChargeResult/{rno}")
	public String chargeResult(@PathVariable long rno,Model model) {
		model.addAttribute("reserve",service.get(rno));
		return "condoreserve/payChargeResult";
	}

	
}
