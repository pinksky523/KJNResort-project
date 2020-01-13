package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;

public interface QnaService {
	public List<QnaVO> getList(Criteria cri);
	public boolean modify(QnaVO qvo);
	public boolean remove(Long qno);
	public QnaVO get(Long qno);
	public void register(QnaVO qvo);
}
