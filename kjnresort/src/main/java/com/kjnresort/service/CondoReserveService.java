package com.kjnresort.service;


import java.util.Calendar;
import java.util.List;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;

public interface CondoReserveService {
	 public List<CondoReserveVO> getListWithPaging(Criteria cri);
	 public List<CondoReserveVO> getListWithId(Criteria cri,String id);
	 public void register(CondoReserveVO reserve);
	 public boolean modify(CondoReserveVO reserve);
	 public CondoReserveVO get(Long reserveNo);
	 public int getTotalCount(Criteria cri);
	 public int getTotalCountWithId(Criteria cri,String id);
	 public List<String> getAvailableRoomType(String roomType,Calendar CheckIn,Calendar checkOut);
}
