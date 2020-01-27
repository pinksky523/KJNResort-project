package com.kjnresort.mapper;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.CondoReserveVO;

import com.kjnresort.domain.Criteria;




public interface CondoReserveMapper {
	   public List<CondoReserveVO> getListWithPaging(Criteria cri);
	   public List<CondoReserveVO> getListWithId(@Param("cri") Criteria cri,@Param("userId") String userId);
	   public int insert(CondoReserveVO reserve);
	   public int update(@Param("reserveNo") Long reserveNo,@Param("status")int status);
	   public CondoReserveVO read(Long reserveNo);
	   public long getMaxReserveNo();
	 
	   public int getMaxRoomNoByRoomType(String roomType);
	   public int getReserveSizeByRoomType(String roomType);
	   
	   public int getOverlapDateCount(@Param("roomType") String roomType,@Param("roomNo") int roomNo,@Param("checkIn") Date checkIn,@Param("checkOut") Date checkOut);
	   public int getReserveRoomNo(@Param("roomType") String roomType,@Param("checkIn") Date checkIn,@Param("checkOut") Date checkOut);
	   public int getTotalCount(Criteria cri);
	   public int getTotalCountWithId(@Param("cri") Criteria cri,@Param("userId") String userId);
	   
	   
	}
