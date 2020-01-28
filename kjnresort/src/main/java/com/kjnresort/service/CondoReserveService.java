package com.kjnresort.service;


import java.util.Calendar;
import java.util.List;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.CondoVO;
import com.kjnresort.domain.Criteria;

public interface CondoReserveService {
	 public List<CondoReserveVO> getListWithPaging(Criteria cri);
	 public List<CondoReserveVO> getListWithId(Criteria cri,String userId);
	 public int register(CondoReserveVO reserve);
	 public long getMaxReserveNo();
	 public boolean modify(Long reserveNo,int status);
	 public CondoReserveVO get(Long reserveNo);
	 public int getTotalCount(Criteria cri);
	 public int getTotalCountWithId(Criteria cri,String id);
	 public List<String> getAvailableRoomType(Calendar checkIn,Calendar checkOut);
	 
}
