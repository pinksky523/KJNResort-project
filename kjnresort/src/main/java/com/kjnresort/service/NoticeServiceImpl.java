package com.kjnresort.service;

import java.util.List;

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
		log.info("getList with paging.......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<NoticeVO> getList() {
		log.info("getList.......");
		return mapper.getList();
	}

	@Override
	public NoticeVO get(Long noticeNo) {
		log.info("get.......");
		return mapper.read(noticeNo);
	}

	@Override
	public boolean modify(NoticeVO notice) {
		log.info("modify....... : " + notice);
		return mapper.update(notice) == 1;
	}

	@Override
	public boolean remove(Long noticeNo) {
		log.info("remove....... : " + noticeNo);
		return mapper.delete(noticeNo) == 1;
	}


	@Override
	public void register(NoticeVO notice) {
		log.info("register........ : " + notice);
		mapper.insertSelectKey(notice);
	}

}
