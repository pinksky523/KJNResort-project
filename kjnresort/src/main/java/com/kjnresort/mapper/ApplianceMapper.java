package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.ApplianceVO;
import com.kjnresort.domain.Criteria;

public interface ApplianceMapper {	
	public int getTotalCount(Criteria cri);
	public List<ApplianceVO> getListWithPaging(Criteria cri);
			
	public void insert(ApplianceVO appliance);
	public ApplianceVO read(String phoneNumber);

}






