package com.kjnresort.mapper;

import java.util.List;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReviewReplyVO;
import com.kjnresort.domain.ReviewVO;

public interface ReviewMapper {
	public int getTotalCount(Criteria cri); 
	public List<ReviewVO> getListWithPaging(Criteria cri);
	
	public void insert(ReviewVO review);
	public int update(ReviewVO review);
	public int delete(Long reviewNo);
	public ReviewVO read(Long reviewNo);
}
