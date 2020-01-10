package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyPageDTO;
import com.kjnresort.domain.ReplyVO;
import com.kjnresort.mapper.BoardMapper;
import com.kjnresort.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper mapper;
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO rvo) {
		log.info("ReplyServiceImpl register() rvo : " + rvo);
		boardMapper.updateReplyCnt(rvo.getBno(), 1);
		return mapper.insert(rvo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("ReplyServiceImpl remove() rno : " + rno);
		ReplyVO rvo = mapper.read(rno);
		boardMapper.updateReplyCnt(rvo.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {		
		return new ReplyPageDTO(mapper.getCountByBno(bno), 
								mapper.getListWithPaging(cri, bno));
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("ReplyServiceImpl getList() bno : " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public int modify(ReplyVO rvo) {
		log.info("ReplyServiceImpl modify() rvo : " + rvo);
		return mapper.update(rvo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("ReplyServiceImpl get() rno : " + rno);
		return mapper.read(rno);
	}
}
