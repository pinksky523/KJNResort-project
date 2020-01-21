package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

	
public interface MemberService {
	public int getTotal(Criteria cri);
	
	public List<MemberVO> getList(Criteria cri);
	
	public boolean modify(MemberVO member);
	
	
	
	public MemberVO get(String id);
	
	public boolean remove(String id);

	///////////////////////////////////////////////
	
	public void register(MemberVO member);
	
	public void registerAuth(AuthVO auth);
	
	public MemberVO idCheck(String id);
	
	public String findId(String name, String phoneNumber);
	
	public String findPw(@Param("id") String id, @Param("name") String name, 
			@Param("phoneNumber") String phoneNumber);
	
	public boolean pwModify(MemberVO member);
}
