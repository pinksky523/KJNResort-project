package com.kjnresort.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	
	
	@GetMapping("register")
	public void register() {
		log.info("회원가입 창 진입");
	}
	
	@PostMapping("register")
	public String register(MemberVO member, RedirectAttributes rttr) {
		log.info("회원가입 완료");
		log.info("회원정보 :" + member);
		log.info("===============================");
		service.register(member);
		log.info("회원정보 DB에 저장완료");
		rttr.addFlashAttribute("result", "회원가입이 완료되었습니다. 로그인 후 이용해주세요");
		return "redirect:/customLogin";
	}
		
	   
	/*
	 * @GetMapping(value="/{id}", produces = {MediaType.APPLICATION_XML_VALUE,
	 * MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<MemberVO>
	 * get(@PathVariable("id") String id){
	 * 
	 * return new ResponseEntity<>(service.idCheck(id), HttpStatus.OK); }
	 */
	
	
	
	
	@GetMapping("list")
	public void memberList(Criteria cri, Model model) {

		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	

	//2페이지의 게시글을 조회한 뒤 list 누르면 다시 2페이지로 가게 하기
	//2페이지의 게시글을 조회하고 수정 화면에서 list 누르면 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	//pageNum, amount 추가	
	//@RequestParam은 안써도 됨
	//@ModelAttribute를 안쓰면 화면 전환될 때 에러 발생
	@GetMapping({"get"})
	public void get(String id, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("member", service.get(id));
	}
	
	@GetMapping({"findId"})
	public void get(String id, String phoneNumber, Model model) {
		model.addAttribute("findId", service.get(id));
	}
	
	@GetMapping({"findPw"})
	public String get(String id, String name, String phoneNumber, Model model) {
		model.addAttribute("findPw", service.get(id));
		
		return "redirect:/member/pwModify";
	}
	
	
	@PostMapping("mypage")
	public String modify(MemberVO member, RedirectAttributes rttr) {
		if(service.modify(member)) {
			rttr.addFlashAttribute("result", "수정");
		}
		
		return "redirect:/";
	}

	
	//2페이지의 게시글을 조회하고 수정 화면에서 remove 누르면 삭제 후 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	@PostMapping("remove")
	public String remove(@RequestParam("id") String id, RedirectAttributes rttr, 
						@ModelAttribute("cri") Criteria cri) {
	
		
		
		if(service.remove(id)) {
			
			
			rttr.addFlashAttribute("result", "삭제");
		}
		
		//Criteria에서 getListLink()를 만들어주었기 때문에 아래 코드를 주석으로 처리함
//		//redirect로 보내기 때문에 이것을 써줘야 함
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		
//		//검색 후 다시 해당 페이지로 이동
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/event/list";
		
		return "redirect:/member/list" + cri.getListlink();
	}
	
	

	//2페이지의 게시글을 조회하고 수정 화면에서 list 누르면 수정 후 다시 2페이지로 가게 하기
	//검색 후에도 마찬가지로 되게 하기
	
	@PostMapping("modify")
	public String modify(MemberVO member, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {

		if(service.modify(member)) {
			rttr.addFlashAttribute("result", "수정");
		}
		
		//Criteria에서 getListLink()를 만들어주었기 때문에 아래 코드를 주석으로 처리함
//		//redirect로 보내기 때문에 이것을 써줘야 함
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		
//		//검색 후 다시 해당 페이지로 이동
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//				
//		return "redirect:/board/list";
		
		return "redirect:/member/list" + cri.getListlink();
	}
	
}
