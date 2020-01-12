package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.NoticeVO;
import com.kjnresort.domain.Criteria;

public interface NoticeMapper {	
	public int getTotalCount(Criteria cri);
	public List<NoticeVO> getListWithPaging(Criteria cri);
	public List<NoticeVO> getList();
	
	public void insertSelectKey(NoticeVO notice);							
	public void insert(NoticeVO notice);
	public int update(NoticeVO notice);
	public int delete(Long noticeNo);
	public NoticeVO read(Long noticeNo);

}






