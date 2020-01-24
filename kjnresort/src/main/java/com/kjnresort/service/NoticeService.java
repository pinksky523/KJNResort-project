package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.NoticeVO;
import com.kjnresort.domain.Criteria;

public interface NoticeService {
	public int getTotalCount(Criteria cri);
	public List<NoticeVO> getList(Criteria cri);
	
	public boolean modify(NoticeVO notice);					// 게시글 수정
	public boolean remove(Long noticeNo);					// 게시글 삭제
	public NoticeVO get(Long noticeNo);						// 게시글 조회
	public void register(NoticeVO notice);					// 게시글 등록
}
