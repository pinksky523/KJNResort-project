package com.kjnresort.mapper;

import java.util.List;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String id);
	
	public int getTotalCount(Criteria cri);
	
	public List<MemberVO> getListWithPaging(Criteria cri);		
	public int update(MemberVO member);	
	public int delete(String id);	
	public void insert(MemberVO member);
	public MemberVO idCheck(String id);


}
