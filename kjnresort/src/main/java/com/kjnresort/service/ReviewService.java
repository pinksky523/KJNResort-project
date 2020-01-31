package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.domain.ReviewVO;
import com.kjnresort.domain.Criteria;

public interface ReviewService {
	public List<ReviewAttachVO> getAttachList(Long reviewNo);
	public int getTotalCount(Criteria cri);
	
	public List<ReviewVO> getList(Criteria cri);
	public boolean modify(ReviewVO review);
	public boolean modifyTReview(Long ticketNo);
	public boolean modifyCReview(Long reserveNo);
	public boolean remove(Long reviewNo);
	public ReviewVO get(Long reviewNo);
	public void register(ReviewVO review);
	
	//내가 쓴 후기 전체개수
	public int getMyTotalCount(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount);	
	
	//내가 쓴 후기 목록
	public List<ReviewVO> getMyList(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	
	
}
