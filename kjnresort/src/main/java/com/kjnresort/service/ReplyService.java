package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyPageDTO;
import com.kjnresort.domain.ReplyVO;

public interface ReplyService {
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	public List<ReplyVO> getList(Criteria cri, Long bno);	//댓글 전체 조회
	public int modify(ReplyVO rvo);	//댓글 수정
	public int remove(Long rno);	//댓글 삭제
	public ReplyVO get(Long rno);	//댓글 조회 
	public int register(ReplyVO rvo);	//댓글 등록
}














