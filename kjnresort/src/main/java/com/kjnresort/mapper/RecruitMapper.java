package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.RecruitVO;

public interface RecruitMapper {
	public List<RecruitVO> getList();
			
	public void insert(RecruitVO recruit);
	public int update(RecruitVO recruit);
	public int delete(Long recruitNo);
	public RecruitVO read(Long recruitNo);
	public ApplianceVO idCheck(String id);		// 지원 내역 중복체크
}






