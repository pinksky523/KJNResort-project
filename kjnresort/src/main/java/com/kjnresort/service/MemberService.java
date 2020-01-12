package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;
import com.kjnresort.domain.MemberVO;

	
public interface MemberService {
	public int getTotal(Criteria cri);
	
	public List<MemberVO> getList(Criteria cri);
	
	public boolean modify(MemberVO member);
	
	public MemberVO get(String id);
	
	public boolean remove(String id);
}
