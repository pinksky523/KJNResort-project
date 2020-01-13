package com.kjnresort.service;

import java.util.List;

public interface CondoManageService {
	public int modify(String roomType,int price);
	public List<Integer> getPriceList();
}
