package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.EventAttachVO;

public interface EventAttachMapper {
	public void deleteAll(Long eventNo);
	
	public void insert(EventAttachVO evo);
	public void delete(String uuid);
	public List<EventAttachVO> findByEventNo(Long eventNo);
	public List<EventAttachVO> getOldFiles();
}
