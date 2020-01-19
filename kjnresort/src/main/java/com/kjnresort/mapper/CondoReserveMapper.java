package com.kjnresort.mapper;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.CondoReserveVO;

import com.kjnresort.domain.Criteria;




public interface CondoReserveMapper {
   public List<CondoReserveVO> getListWithPaging(Criteria cri);
   public List<CondoReserveVO> getListWithId(Criteria cri,String id);
   public void insert(CondoReserveVO reserve);
   public int update(CondoReserveVO reserve);
   public CondoReserveVO read(Long reserveNo);
   
 
   public int getMaxRoomNoByRoomType(String roomType);
   public int getReserveSizeByRoomType(String roomType);
   
   public int getOverlapDateCount(@Param("roomType") String roomType,@Param("roomNo") int roomNo,@Param("checkIn") Date checkIn,@Param("checkOut") Date checkOut);
   public int getReserveRoomNo(@Param("roomType") String roomType,@Param("checkIn") Date checkIn,@Param("checkOut") Date checkOut);
   //Å×½ºÆ®
   public void insertdate(Date mydate);
   public Date get();
}
