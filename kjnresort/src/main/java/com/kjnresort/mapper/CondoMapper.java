package com.kjnresort.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.CondoVO;

public interface CondoMapper {
	public int update(@Param("roomType") String roomType,@Param("price") int price);
	public List<CondoVO> getCondoList();
	public int getPriceByRoomType(String roomType);
	public CondoVO get(String roomType);
	
}
