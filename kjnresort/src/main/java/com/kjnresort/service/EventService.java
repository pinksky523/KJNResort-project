package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;

	
public interface EventService {
	public int getTotal(Criteria cri);
	
	public List<EventVO> getList(Criteria cri);
	
	public boolean modify(EventVO event);
	
	public boolean remove(Long eventNo);
	
	public EventVO get(Long eventNo);
	
	public void register(EventVO event);
	
	public List<EventAttachVO> getAttachList(Long eventNo);

}
