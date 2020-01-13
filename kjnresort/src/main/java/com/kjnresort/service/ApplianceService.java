package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;

public interface ApplianceService {
	public int getTotalCount(Criteria cri);
	public List<ApplianceVO> getList(Criteria cri);
	public List<ApplianceVO> getList();
	
	public ApplianceVO get(String phoneNumber);
	public void register(ApplianceVO appliance);
}
