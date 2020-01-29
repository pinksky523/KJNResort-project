package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.MemberVO;
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
	public List<RecruitVO> getList() {
		log.info("getList .......");
		return mapper.getList();
	}

	@Override
	public RecruitVO get(Long recruitNo) {
		log.info("get......." + recruitNo);
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
		mapper.insert(recruit);
	}
	
	@Transactional
	@Override
	public ApplianceVO idCheck(String id) {
		log.info("지원내역 중복 확인 서비스임플 진입");
		return mapper.idCheck(id);
	}
	

}















