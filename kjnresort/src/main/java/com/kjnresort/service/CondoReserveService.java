package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;

public interface CondoReserveService {
	 public List<CondoReserveVO> getListWithPaging(Criteria cri);
	 public void register(CondoReserveVO reserve);
	 public int modify(CondoReserveVO reserve);
	 public CondoReserveVO get(Long rno);
}
