package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.NoticeVO;
import com.kjnresort.domain.Criteria;

public interface NoticeService {
	public int getTotalCount(Criteria cri);
	public List<NoticeVO> getList(Criteria cri);
	public List<NoticeVO> getList();
	
	public boolean modify(NoticeVO notice);
	public boolean remove(Long noticeNo);
	public NoticeVO get(Long noticeNo);
	public void register(NoticeVO notice);
}
