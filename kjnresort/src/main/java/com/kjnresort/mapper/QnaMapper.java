package com.kjnresort.mapper;

import java.util.List;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;

public interface QnaMapper {
	   public List<QnaVO> getListWithPaging(Criteria cri);
	   public void intsert(QnaVO question);
	   public int update(QnaVO question);
	   public QnaVO read(Long qno);
}
