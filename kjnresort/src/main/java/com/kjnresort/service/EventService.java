package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;

	
public interface EventService {
	public List<EventVO> getList(Criteria cri);		//게시글 목록
	public int getTotal(Criteria cri);				//게시글 전체개수 가져오기
	public void register(EventVO event);			//게시글 등록
	public EventVO get(Long eventNo);				//게시글 상세조회
	public List<EventAttachVO> getAttachList(Long eventNo);	//첨부파일 리스트
	public boolean modify(EventVO event);			//게시글 수정
	public boolean remove(Long eventNo);			//게시글 삭제
	public boolean updateViewCnt(Long eventNo);			//조회수 업데이트
}
