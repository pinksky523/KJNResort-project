package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.mapper.CondoReserveMapper;
import com.kjnresort.mapper.CondoUtilMapper;

public class CondoReserveServiceImpl implements CondoReserveService {
	CondoReserveMapper condoReservemapper;
	CondoUtilMapper condoUtilMapper;
	public List<CondoReserveVO> getListWithPaging(Criteria cri){
		return null;
	}
	 public void register(CondoReserveVO reserve) {
		 
	 }
	 public int modify(CondoReserveVO reserve) {
		 return 0;
	 }
	 public CondoReserveVO get(Long rno) {
		 return null;
	 }
	
	public List<CondoReserveVO> getListWithId(Criteria cri, String id) {
		
		return null;
	}
	
	public int getTotalCount(Criteria cri) {
		
		return 0;
	}

	public int getTotalCountWithId(Criteria cri, String id) {
	
		return 0;
	}
	
}
