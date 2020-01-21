package com.kjnresort.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/common/*")
public class CommonController {
	private MemberService service;
	
	@GetMapping("memberJoin")
	public void register() {
		log.info("회원가입 창 진입");
	}
	
	@PostMapping("register")
	public String register(MemberVO member, AuthVO auth, RedirectAttributes rttr) {
		log.info("회원가입 완료");
		log.info("회원정보 :" + member);
		log.info("===============================");
		service.register(member);
		service.registerAuth(auth);
		log.info("회원정보 DB에 저장완료");
		rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다. 로그인 후 이용해주세요");
		return "redirect:/common/customLogin";
	}
	
	@GetMapping({"findId"})
	public void findIdGet() {
		log.info("아이디찾기 창 진입");
	}
	
	@PostMapping({"findId"})
	public String findIdPost(@Param("name") String name, @Param("phoneNumber") String phoneNumber, RedirectAttributes rttr) {
		
		String id = service.findId(name, phoneNumber);
		
		if (id == null) {
			rttr.addFlashAttribute("msg", "일치하는 회원정보가 없습니다.");
			return "redirect:/common/findId";
		} else {
			rttr.addFlashAttribute("msg", "회원님의 ID는 " + id + " 입니다.");
			return "redirect:/common/customLogin";
		}
		
	}
	
	@GetMapping({"findPw"})
	public void findPwGet() {
		log.info("비밀번호찾기 창 진입");
	}
	
	@PostMapping({"findPw"})
	public String findPwPost(@Param("id") String id, @Param("name") String name, 
			@Param("phoneNumber") String phoneNumber, RedirectAttributes rttr, Model model) {
		
		//값이 존재하는지만 확인위해 regDate 반환
		String regDate = service.findPw(id, name, phoneNumber);
		
		if (regDate == null) {
			rttr.addFlashAttribute("msg", "일치하는 회원정보가 없습니다.");
			return "redirect:/common/findPw";
		} else {
			rttr.addFlashAttribute("msg", "비밀번호 변경페이지로 이동합니다.");
			rttr.addFlashAttribute("id", id);
			return "redirect:/common/pwModify";
		}
	}
	
	@GetMapping({"pwModify"})
	public void pwModifyGet(HttpServletRequest request, Model model) {
		log.info("비밀번호변경 창 진입");
	}
	
	@PostMapping({"pwModify"})
	public String pwModifyPost(MemberVO member, RedirectAttributes rttr) {
		
		boolean result = service.pwModify(member);
		
		if (result == true) {
			rttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
			return "redirect:/common/customLogin";
		} else {
			rttr.addFlashAttribute("msg", "비밀번호 변경 실패. 다시 시도해주세요.");
			return "redirect:/common/findPw";
		}
	}
	
	
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("conmmonController accessDenied() : " + auth);
		model.addAttribute("msg", "로그인 후 이용해주세요");
		return "redirect:/common/customLogin";
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("msg", "로그인 에러. 계정을 확인해 주세요.");
			log.info("에러1");
		}
		
		if(logout != null) {
			model.addAttribute("msg", "로그아웃!!");
			log.info("에러2");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGet(){
	}
	
	@GetMapping("customLoginError")
	public String customLoginError(RedirectAttributes rttr) {
		rttr.addFlashAttribute("msg", "아이디와 비밀번호를 다시 확인해주세요");
		return "redirect:/common/customLogin";
	}
	
	@GetMapping("/home")
	public void commonMain() {
	}
}
