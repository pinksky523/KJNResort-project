package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;

public interface QnaMapper {
	   public List<QnaVO> getListWithPaging(Criteria cri);
	   public List<QnaVO> getListWithId(@Param("cri")Criteria cri,@Param("id")String id);
	   public void insert(QnaVO qvo);
	   public int update(QnaVO qvo);
	   public int delete(Long qnaNo);
	   public QnaVO read(Long qnaNo);
	   public int updateAnswer(QnaVO qvo);//답변 등록
	   public int deleteAnswer(Long qnaNo);
	   public int getTotalCount(Criteria cri);
	   public int getTotalCountWithId(@Param("cri")Criteria cri,@Param("id")String id);
}
