package com.kjnresort.mapper;

import java.util.List;


import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;

public interface QnaMapper {
	   public List<QnaVO> getListWithPaging(Criteria cri);
	   public List<QnaVO> getListWithId(Criteria qnaCri,String id);
	   public void insert(QnaVO qvo);
	   public int update(QnaVO qvo);
	   public int delete(Long qno);
	   public QnaVO read(Long qno);
	   public int updateAnswer(QnaVO qvo);//답변 등록
	   public int deleteAnswer(Long qno);
	   public int getTotalCount(Criteria cri);
	   public int getTotalCountWithId(Criteria cri,String id);
}
