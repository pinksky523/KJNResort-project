package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.CondoVO;

public interface CondoService {
	public boolean modify(String roomType,int price);
	public List<CondoVO> getCondoList();
	public CondoVO get(String roomType); 
}
