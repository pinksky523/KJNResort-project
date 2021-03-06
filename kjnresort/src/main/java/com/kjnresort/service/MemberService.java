package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.ReviewVO;

	
public interface MemberService {
	public MemberVO get(String id);				//로그인
	public void register(MemberVO member);		//회원가입
	public void registerAuth(AuthVO auth);		//회원권한등록
	public MemberVO idCheck(String id);			//회원가입 아이디 중복체크
	public MemberVO phoneNumberCheck(String phoneNumber);			//회원가입 핸드폰번호 중복체크
	public String findId(String name, String phoneNumber);	//아이디찾기
	public String findPw(String id, String name, String phoneNumber);	//비밀번호찾기
	public boolean pwModify(MemberVO member);		//비밀번호변경
	public MemberVO mypageGet(MemberVO member);		//마이페이지 조회
	public boolean modifyMypage(MemberVO member);	//마이페이지 수정
	public boolean remove(MemberVO member);			//회원탈퇴
	public List<ReviewVO> myreviewList(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount);	//내가 쓴 리뷰 목록 페이징
	public int getTotalMyReview(@Param("id") String id, Criteria cri);	//내가 쓴 리뷰 전체개수 가져오기
	public List<MemberVO> getMemberList(Criteria cri);	//회원목록 페이징
	public int getTotalMember(Criteria cri);		//전체 회원 수 가져오기
	public MemberVO getMember(String id);		//회원상세조회 (관리자) 
	public boolean statusModify(MemberVO member);	//회원 상태수정(관리자)
}
