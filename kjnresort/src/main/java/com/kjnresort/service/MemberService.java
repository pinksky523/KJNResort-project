package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

	
public interface MemberService {
	public int getTotal(Criteria cri);
	
	public List<MemberVO> getList(Criteria cri);
	
	public boolean modify(MemberVO member);
	
	public MemberVO get(String id);
	
	public boolean remove(String id);

	public void register(MemberVO member);
	
	public void registerAuth(AuthVO auth);
	
	public MemberVO idCheck(String id);
}
