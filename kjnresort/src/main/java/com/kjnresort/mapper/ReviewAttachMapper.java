package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ReviewAttachVO;

public interface ReviewAttachMapper {
	public void insert(ReviewAttachVO vo);
	
	public void delete(String uuid);
	
	public List<ReviewAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
	
	public List<ReviewAttachVO> getOldFiles();
}
