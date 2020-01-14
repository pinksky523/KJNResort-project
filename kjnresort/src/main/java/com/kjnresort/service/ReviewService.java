package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.domain.ReviewVO;
import com.kjnresort.domain.Criteria;

public interface ReviewService {
	public List<ReviewAttachVO> getAttachList(Long reviewNo);
	public int getTotalCount(Criteria cri);
	public List<ReviewVO> getList(Criteria cri);
	
	public boolean modify(ReviewVO review);
	public boolean remove(Long reviewNo);
	public ReviewVO get(Long reviewNo);
	public void register(ReviewVO review);
}
