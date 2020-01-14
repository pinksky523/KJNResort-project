package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.CondoManageVO;

public interface CondoManageService {
	public int modify(CondoManageVO cmvo);
	public List<Integer> getPriceList();
}
