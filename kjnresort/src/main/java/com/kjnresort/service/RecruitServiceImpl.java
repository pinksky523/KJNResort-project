package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.RecruitVO;
import com.kjnresort.mapper.RecruitMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class RecruitServiceImpl implements RecruitService {
	private RecruitMapper mapper;
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount .......");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<RecruitVO> getList(Criteria cri) {
		log.info("getList with paging.......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<RecruitVO> getList() {
		log.info("getList.......");
		return mapper.getList();
	}

	@Override
	public RecruitVO get(Long recruitNo) {
		log.info("get.......");
		return mapper.read(recruitNo);
	}

	@Override
	public boolean modify(RecruitVO recruit) {
		log.info("modify....... : " + recruit);
		return mapper.update(recruit) == 1;
	}

	@Override
	public boolean remove(Long recruitNo) {
		log.info("remove....... : " + recruitNo);
		return mapper.delete(recruitNo) == 1;
	}

	@Override
	public void register(RecruitVO recruit) {
		log.info("register........ : " + recruit);
		mapper.insertSelectKey(recruit);
	}

}















