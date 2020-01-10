package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyVO;

public interface ReplyMapper {
	public int getCountByBno(Long bno);
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, 
										   @Param("bno") Long bno);	//댓글 전체 조회
	public int update(ReplyVO rvo);	//댓글 수정
	public int delete(Long rno);	//댓글 삭제
	public ReplyVO read(Long rno);	//댓글 조회 
	public int insert(ReplyVO rvo);	//댓글 등록
}	


















