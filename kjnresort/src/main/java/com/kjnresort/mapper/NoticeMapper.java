package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.NoticeVO;
import com.kjnresort.domain.Criteria;

public interface NoticeMapper {	
	public int getTotalCount(Criteria cri);
	public List<NoticeVO> getListWithPaging(Criteria cri);
							
	public void insert(NoticeVO notice);					// 게시글 등록
	public int update(NoticeVO notice);						// 게시글 수정
	public int delete(Long noticeNo);						// 게시글 삭제
	public NoticeVO read(Long noticeNo);					// 게시글 조회
	public void updateViewCnt(Long noticeNo);				// 조회수 증가

}






