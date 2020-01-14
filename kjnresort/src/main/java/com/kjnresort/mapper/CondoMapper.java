package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.CondoVO;

public interface CondoMapper {
	public int update(CondoVO cmvo);
	public List<Integer> getPriceList();
}
