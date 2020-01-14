package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaCriteria;
import com.kjnresort.domain.QnaVO;

public interface QnaService {
	public List<QnaVO> getListWithPaging(QnaCriteria qnaCri);
	public List<QnaVO> getListWithId(QnaCriteria qnaCri,String id);
	public boolean modify(QnaVO qvo);
	public boolean remove(Long qno);
	public QnaVO get(Long qno);
	public void register(QnaVO qvo);
	public boolean modifyAnswer(QnaVO qvo);
	public boolean deleteAnswer(Long qno);
	public int getTotalCount(QnaCriteria qnaCri);
	public int getTotalCountWithId(QnaCriteria qnaCri,String id);
}
