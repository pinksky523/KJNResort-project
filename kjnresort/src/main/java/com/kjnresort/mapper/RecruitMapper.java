package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.RecruitVO;
import com.kjnresort.domain.Criteria;

public interface RecruitMapper {	
	public int getTotalCount(Criteria cri);
	public List<RecruitVO> getListWithPaging(Criteria cri);
			
	public void insert(RecruitVO recruit);
	public int update(RecruitVO recruit);
	public int delete(Long recruitNo);
	public RecruitVO read(Long recruitNo);
}






