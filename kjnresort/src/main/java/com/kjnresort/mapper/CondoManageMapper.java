package com.kjnresort.mapper;

import java.util.List;

public interface CondoManageMapper {
	public int update(String roomType,int price);
	public List<Integer> getPriceList();
}
