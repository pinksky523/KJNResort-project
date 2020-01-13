package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaCriteria;
import com.kjnresort.domain.QnaVO;
import com.kjnresort.mapper.QnaMapper;

public class QnaServiceImpl implements QnaService {
	QnaMapper mapper;
	public List<QnaVO> getListWithPaging(QnaCriteria qnaCri){
		return null;
	}
	
	public List<QnaVO> getListWithId(QnaCriteria qnaCri,String id){
		return null;
	}
	
	public boolean modify(QnaVO qvo) {
		return false;
	}
	public boolean remove(Long qno) {
		return false;
	}
	public QnaVO get(Long qno) {
		return null;
	}
	public void register(QnaVO qvo) {
		
	}
	public boolean modifyAnswer(QnaVO qvo) {
		return false;
	}
	public boolean deleteAnswer(Long qno) {
		return false;
	}
	public int getTotalCount(QnaCriteria qnaCri) {
		return 0;
	}
	
	public int getTotalCountWithId(QnaCriteria qnaCri,String id) {
		return 0;
	}

	
}
