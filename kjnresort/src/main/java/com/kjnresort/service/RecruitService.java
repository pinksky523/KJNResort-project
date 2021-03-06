package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.RecruitVO;

public interface RecruitService {
	public List<RecruitVO> getList();
	
	public boolean modify(RecruitVO recruit);
	public boolean remove(Long recruitNo);
	public RecruitVO get(Long recruitNo);
	public void register(RecruitVO recruit);
	public ApplianceVO idCheck(String id);			// 지원내역 중복체크
}
