package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.kjnresort.domain.Criteria;
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
		log.info("getList with paging.......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<ApplianceVO> getList() {
		log.info("getList.......");
		return mapper.getList();
	}

	@Override
	public ApplianceVO get(String phoneNumber) {
		log.info("get.......");
		return mapper.read(phoneNumber);
	}

	@Override
	public void register(ApplianceVO appliance) {
		log.info("register........ : " + appliance);
		mapper.insertSelectKey(appliance);
	}

}
