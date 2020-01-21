package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;

public interface ApplianceMapper {	
	public int getTotalCount(Criteria cri);
	public List<ApplianceVO> getListWithPaging(Criteria cri);		// 게시글 목록(관리자)
	public List<ApplianceVO> getList();								// 게시글 목록(사용자)
			
	public void insert(ApplianceVO appliance);						// 게시글 등록(사용자)
	public int update(ApplianceVO appliance);						// 게시글 수정(사용자)
	public ApplianceVO read(String id);								// 게시글 조회(관리자)
	
}






