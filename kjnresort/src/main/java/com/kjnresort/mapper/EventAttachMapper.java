package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.EventAttachVO;

public interface EventAttachMapper {
	public void delete(String uuid);			//지난 파일 삭제
	public List<EventAttachVO> getOldFiles();	//지난 파일 찾기
	public void insert(EventAttachVO evo);		//첨부파일리스트 등록
	public List<EventAttachVO> findByEventNo(Long eventNo);		//첨부파일리스트 목록
	public void deleteAll(Long eventNo);					//이벤트 게시글 수정창에서 첨부파일 삭제할경우
}
