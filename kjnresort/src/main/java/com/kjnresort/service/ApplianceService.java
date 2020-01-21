package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;

public interface ApplianceService {
	public int getTotalCount(Criteria cri);				// 페이징
	public List<ApplianceVO> getList(Criteria cri);		// 게시글 목록(관리자)
	public List<ApplianceVO> getList();					// 게시글 목록(사용자)
	
	public ApplianceVO get(String id);					// 게시글 조회
	public void register(ApplianceVO appliance);		// 게시글 등록
	public boolean modify(ApplianceVO appliance);		// 게시글 수정(임시저장)
}
