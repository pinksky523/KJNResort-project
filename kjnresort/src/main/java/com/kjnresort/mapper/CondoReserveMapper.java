package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;

public interface CondoReserveMapper {
   public List<CondoReserveVO> getListWithPaging(Criteria cri);
   public List<CondoReserveVO> getListWithId(Criteria cri,String id);
   public void intsert(CondoReserveVO reserve);
   public int update(CondoReserveVO reserve);
   public CondoReserveVO read(Long rno);
}
