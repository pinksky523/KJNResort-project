package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.ReviewVO;

public interface MemberMapper {
	public MemberVO read(String id);	//권한조회
	public void insert(MemberVO member);	//회원가입
	public void insertAuth(AuthVO auth);	//회원가입 자동권한생성
	public MemberVO idCheck(String id);		//회원가입 아이디 중복체크
	public MemberVO phoneNumberCheck(String phoneNumber);		//회원가입 핸드폰번호 중복체크
	public String findId(@Param("name") String name, @Param("phoneNumber") String phoneNumber);	//아이디찾기
	public String findPw(@Param("id") String id, @Param("name") String name, @Param("phoneNumber") String phoneNumber);	//비밀번호찾기
	public int pwUpdate(MemberVO member);	//비밀번호 변경
	public MemberVO mypageRead(MemberVO member);	//마이페이지 조회
	public boolean mypageUpdate(MemberVO member);	//마이페이지 수정
	public boolean mypageUpdate2(MemberVO member);	//마이페이지 비밀번호 제외 수정
	public int delete(MemberVO member);			//마이페이지 회원탈퇴
	public List<ReviewVO> myreviewList(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount);		//내가 쓴 리뷰 목록
	public int getTotalMyReview(@Param("id") String id, Criteria cri);		//내 리뷰 전체 개수 가져오기
	public List<MemberVO> memberList(Criteria cri);	//전체회원목록
	public int totalMemberCount(Criteria cri);		//전체회원 수 가져오기
}
