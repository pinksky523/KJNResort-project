package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.CondoVO;

public interface CondoManageMapper {
	public int update(CondoVO cmvo);
	public List<Integer> getPriceList();
}
