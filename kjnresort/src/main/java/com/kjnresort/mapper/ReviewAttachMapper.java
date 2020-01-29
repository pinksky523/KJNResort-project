package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ReviewAttachVO;

public interface ReviewAttachMapper {
	public void insert(ReviewAttachVO vo);
	
	public void delete(String uuid);
	
	public List<ReviewAttachVO> findByReviewNo(Long reviewNo);
	
	public void deleteAll(Long reviewNo);
	
	public List<ReviewAttachVO> getOldFiles();
}
