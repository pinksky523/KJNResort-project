package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.CondoVO;

public interface CondoService {
	public int modify(CondoVO cmvo);
	public List<Integer> getPriceList();
	public CondoVO get(String roomType); 
}
