package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.RecruitVO;
import com.kjnresort.domain.Criteria;

public interface RecruitService {
	public int getTotalCount(Criteria cri);
	public List<RecruitVO> getList(Criteria cri);
	public List<RecruitVO> getList();
	
	public boolean modify(RecruitVO recruit);
	public boolean remove(Long recruitNo);
	public RecruitVO get(Long recruitNo);
	public void register(RecruitVO recruit);
}
