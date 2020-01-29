package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.RecruitVO;
import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.mapper.ApplianceMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ApplianceServiceImpl implements ApplianceService {
	private ApplianceMapper mapper;
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount .......");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<ApplianceVO> getList(Criteria cri) {
		log.info("회원 지원내역 조회");
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<ApplianceVO> getList(String id) {
		log.info("나의 지원내역 조회");
		return mapper.getList(id);
	}

	@Override
	public ApplianceVO get(Long applianceNo) {
		log.info("게시글 조회 : " + applianceNo);
		return mapper.read(applianceNo);
	}

	@Override
	public void register(ApplianceVO appliance) {
		log.info("지원서 등록 : " + appliance);
		mapper.insert(appliance);
	}

	@Override
	public void save(ApplianceVO appliance) {
		log.info("지원서 임시저장 : " + appliance);
		mapper.save(appliance);
	}
	
	@Override
	public boolean modifyRegister(ApplianceVO appliance) {
		log.info("임시저장한 지원서를 제출 : " + appliance);
		return mapper.updateInsert(appliance) == 1;
	}
	
	@Override
	public boolean modify(ApplianceVO appliance) {
		log.info("임시저장한 지원서를 임시저장 : " + appliance);
		return mapper.update(appliance) == 1;
	}

	@Override
	public MemberVO memberGet(MemberVO member) {
		return mapper.memberRead(member);
	}

	@Override
	public RecruitVO recruitGet(RecruitVO recruit) {
		return mapper.recruitRead(recruit);
	}

	@Override
	public ApplianceVO applianceGet(ApplianceVO appliance) {
		log.info("DB에 저장되어 있는 지원정보 불러옴");
		return mapper.applianceRead(appliance);
	}



}
