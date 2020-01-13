package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ReviewVO;
import com.kjnresort.domain.Criteria;

public interface ReviewMapper {
	public int getTotalCount(Criteria cri); 
	public List<ReviewVO> getListWithPaging(Criteria cri);

//	@Select("SELECT * FROM tbl_board WHERE bno > 0")
	public List<ReviewVO> getList();
							
	public void insert(ReviewVO review);
	public int update(ReviewVO review);
	public int delete(Long reviewNo);
	public ReviewVO read(Long reviewNo);
}
