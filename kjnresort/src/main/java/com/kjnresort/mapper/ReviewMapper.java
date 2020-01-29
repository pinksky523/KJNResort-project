package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.ReviewReplyVO;
import com.kjnresort.domain.ReviewVO;

public interface ReviewMapper {
	public int getTotalCount(Criteria cri); 
	public List<ReviewVO> getListWithPaging(Criteria cri);
	
	public void insert(ReviewVO review);
	public int update(ReviewVO review);
	public int updateTReview(Long ticketNo);
	public int delete(Long reviewNo);
	public ReviewVO read(Long reviewNo);
<<<<<<< HEAD
	public void updateViewCnt(Long reviewNo);
=======
	
	//내가 쓴 후기 전체개수
	public int getMyTotalCount(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount); 
	
	//내가 쓴 후기 목록
	public List<ReviewVO> getMyListWithPaging(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount);
>>>>>>> branch 'master' of https://github.com/jsnow0819/Project.git
}
