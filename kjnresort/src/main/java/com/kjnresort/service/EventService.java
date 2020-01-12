package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;

	
public interface EventService {
	public int getTotal(Criteria cri);
	
	public List<EventVO> getList(Criteria cri);
	
	public boolean modify(EventVO event);
	
	public boolean remove(Long event_no);
	
	public EventVO get(Long event_no);
	
	public void register(EventVO event);
	
	public List<EventAttachVO> getAttachList(Long event_no);

}
