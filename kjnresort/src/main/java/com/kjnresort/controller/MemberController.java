package com.kjnresort.controller;




import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	
	//회원 목록 창
	@GetMapping("list")
	public void memberList(Criteria cri, Model model) {
		log.info("회원목록 창 진입");
		model.addAttribute("list", service.getMemberList(cri));
		
		int total = service.getTotalMember(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	
	
	//내가 쓴 후기 버튼
	@PostMapping("myreview")
	public void myReviewList(@Param("id") String id, Criteria cri, Model model) {
		log.info("내가 쓴 후기 창 진입");
		int pageNum = cri.getPageNum();
		int amount = cri.getAmount();
		model.addAttribute("list", service.myreviewList(id, pageNum, amount));
		
		int total = service.getTotalMyReview(id, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	//마이페이지 회원탈퇴 버튼
	@PostMapping("remove")
	public String remove(MemberVO member, RedirectAttributes rttr, HttpSession session) {
		
		
		if(service.remove(member)) {
			rttr.addFlashAttribute("msg", "계정이 삭제되었습니다");
			
			session.invalidate();
			return "/common/logout";
		} else {
			rttr.addFlashAttribute("msg", "계정 삭제 실패");
			return "redirect:/member/mypage?id=" + member.getId();
		}
		
	}

	//마이페이지 버튼
	@PostMapping("mypage")
	public void mypageGet(MemberVO member, Model model) {
		log.info("마이페이지 창 진입");
		
		
		model.addAttribute("member", service.mypageGet(member));
	}
	
	
	//마이페이지 수정버튼
	@PostMapping("mypageModify")
	public String mypagePost(MemberVO member, RedirectAttributes rttr) {
		String message;
		
		if(service.modifyMypage(member)) {
			message = "정보가 수정되었습니다.";
		} else {
			message = "정보 수정 실패";
		}
		
		
		rttr.addFlashAttribute("msg", message);
		return "redirect:/member/mypage?id=" + member.getId();
	}
}
