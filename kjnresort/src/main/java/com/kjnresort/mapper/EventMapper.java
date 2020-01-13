package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventVO;

public interface EventMapper {
	//메모 전체 개수 가져오기
	public int getTotalCount(Criteria cri);
	
	//Memo list with page
	public List<EventVO> getListWithPaging(Criteria cri);		
	public int update(EventVO event);	
	public int delete(Long eventNo);	
	public EventVO read(Long eventNo);	
	public void insert(EventVO event);

}
