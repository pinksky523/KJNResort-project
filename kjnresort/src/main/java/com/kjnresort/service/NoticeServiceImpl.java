package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.NoticeVO;
import com.kjnresort.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	private NoticeMapper mapper;
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount .......");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		log.info("공지사항 리스트 조회");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public NoticeVO get(Long noticeNo) {
		log.info("게시글 조회 :" + noticeNo);
		mapper.updateViewCnt(noticeNo);							// 게시글을 조회할때 조회수 1증가
		return mapper.read(noticeNo);
	}

	@Override
	public boolean modify(NoticeVO notice) {
		log.info("게시글 수정 : " + notice);
		return mapper.update(notice) == 1;
	}

	@Override
	public boolean remove(Long noticeNo) {
		log.info("게시글 삭제 : " + noticeNo);
		return mapper.delete(noticeNo) == 1;
	}

	@Override
	public void register(NoticeVO notice) {
		log.info("게시글 등록 : " + notice);
		mapper.insert(notice);
	}


}
