package com.kjnresort.controller;




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
import com.kjnresort.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	
	
	@PostMapping("myreview")
	public void list(@Param("id") String id, Criteria cri, Model model) {
		log.info("내가 쓴 후기 창 진입");
		log.info("내가쓴후기 컨트롤러 id 값체크 : " + id);
		log.info("내가쓴후기 컨트롤러 cri 값체크 : " + cri);
		int pageNum = cri.getPageNum();
		int amount = cri.getAmount();
		model.addAttribute("list", service.myreviewList(id, pageNum, amount));
		
		int total = service.getTotalMyReview(id, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		log.info("total" + total);
	}
	
	
	//마이페이지 회원탈퇴 버튼
	@PostMapping("remove")
	public String remove(MemberVO member, RedirectAttributes rttr) {
		
		
		if(service.remove(member)) {
			rttr.addFlashAttribute("msg", "계정이 삭제되었습니다");
			
			return "/common/logout";
		} else {
			rttr.addFlashAttribute("msg", "계정 삭제 실패");
			return "redirect:/member/mypage?id=" + member.getId();
		}
		
	}

	//마이페이지 버튼
	@GetMapping("mypage")
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
