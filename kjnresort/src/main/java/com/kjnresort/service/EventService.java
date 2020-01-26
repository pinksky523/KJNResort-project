package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;

	
public interface EventService {
	
	public boolean modify(EventVO event);
	
	public boolean remove(Long eventNo);
	
	public EventVO get(Long eventNo);
	
	public List<EventAttachVO> getAttachList(Long eventNo);
	
	///////////////////////////////////////
	
	public List<EventVO> getList(Criteria cri);		//게시글 목록
	public int getTotal(Criteria cri);				//게시글 전체개수 가져오기
	public void register(EventVO event);			//게시글 등록
}
