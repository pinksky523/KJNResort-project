package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String id);	//권한조회
	
	public int getTotalCount(Criteria cri);
	
	public List<MemberVO> getListWithPaging(Criteria cri);		
	
	////////////////////////////////////////////
	
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
}
