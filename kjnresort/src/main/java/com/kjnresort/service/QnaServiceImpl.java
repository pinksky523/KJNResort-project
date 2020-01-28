package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.QnaVO;
import com.kjnresort.mapper.QnaMapper;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class QnaServiceImpl implements QnaService {
	QnaMapper qnaMapper;
	public List<QnaVO> getListWithPaging(Criteria cri){
		return qnaMapper.getListWithPaging(cri);
	}
	
	public List<QnaVO> getListWithId(Criteria cri,String id){
		return qnaMapper.getListWithId(cri, id);
	}
	
	public boolean modify(QnaVO qvo) {
		return qnaMapper.update(qvo)==1;
	}
	public boolean remove(Long qno) {
		return qnaMapper.delete(qno)==1;
	}
	public QnaVO get(Long qno) {
		return qnaMapper.read(qno);
	}
	public void register(QnaVO qvo) {
		qnaMapper.insert(qvo);
	}
	
	public boolean deleteAnswer(Long qno) {
		return qnaMapper.deleteAnswer(qno)==1;
	}
	public int getTotalCount(Criteria cri) {
		return qnaMapper.getTotalCount(cri);
	}
	
	public int getTotalCountWithId(Criteria cri,String id) {
		return qnaMapper.getTotalCountWithId(cri, id);
	}

	@Override
	public boolean registerAnswer(Long qnaNo, String answer) {
		return qnaMapper.registerAnswer(qnaNo, answer)==1;
	}

	
}
