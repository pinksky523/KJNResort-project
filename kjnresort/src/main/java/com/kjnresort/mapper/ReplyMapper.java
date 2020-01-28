package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReviewReplyVO;

public interface ReplyMapper {
	public int getCountByReviewNo(Long reviewNo);
	public List<ReviewReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("reviewNo") Long reviewNo);	//댓글 전체 조회
	public int update(ReviewReplyVO rvo);	//댓글 수정
	public int delete(Long replyNo);	//댓글 삭제
	public ReviewReplyVO read(Long replyNo);	//댓글 조회 
	public int insert(ReviewReplyVO rvo);	//댓글 등록
}	


















