package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventVO;

public interface EventMapper {
	public int update(EventVO event);	
	public int delete(Long eventNo);	
	
	
	///////////////////////////////////////////
	public List<EventVO> getListWithPaging(Criteria cri);	//이벤트게시글 목록
	public int getTotalCount(Criteria cri);					//이벤트 게시글 전체개수 가져오기
	public void insert(EventVO event);						//이벤트 게시글 등록
	public EventVO read(Long eventNo);						//이벤트 게시글 상세조회
}
