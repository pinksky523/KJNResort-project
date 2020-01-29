package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyPageDTO;
import com.kjnresort.domain.ReviewReplyVO;

public interface ReplyService {
	public ReplyPageDTO getListPage(Criteria cri, Long reviewNo);
	public List<ReviewReplyVO> getList(Criteria cri, Long reviewNo);	//댓글 전체 조회
	public int modify(ReviewReplyVO rvo);	//댓글 수정
	public int remove(Long replyNo);	//댓글 삭제
	public ReviewReplyVO get(Long replyNo);	//댓글 조회 
	public int register(ReviewReplyVO rvo);	//댓글 등록
}














