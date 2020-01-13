package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.CondoManageVO;

public interface CondoManageMapper {
	public int update(CondoManageVO cmvo);
	public List<Integer> getPriceList();
}
