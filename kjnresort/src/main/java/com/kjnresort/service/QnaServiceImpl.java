package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;
import com.kjnresort.mapper.QnaMapper;

public class QnaServiceImpl implements QnaService {
	QnaMapper mapper;
	public List<QnaVO> getList(Criteria cri){
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
}
