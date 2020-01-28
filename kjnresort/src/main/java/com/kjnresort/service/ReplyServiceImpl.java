package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReplyPageDTO;
import com.kjnresort.domain.ReviewReplyVO;
import com.kjnresort.mapper.ReplyMapper;
import com.kjnresort.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper mapper;
	private ReviewMapper reviewMapper;

	@Transactional
	@Override
	public int register(ReviewReplyVO rvo) {
		log.info("ReplyServiceImpl register() rvo : " + rvo);
		return mapper.insert(rvo);
	}

	@Transactional
	@Override
	public int remove(Long replyNo) {
		log.info("ReplyServiceImpl remove() replyNo : " + replyNo);
		ReviewReplyVO rvo = mapper.read(replyNo);
		return mapper.delete(replyNo);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long reviewNo) {		
		return new ReplyPageDTO(mapper.getCountByReviewNo(reviewNo), 
								mapper.getListWithPaging(cri, reviewNo));
	}
	
	@Override
	public List<ReviewReplyVO> getList(Criteria cri, Long reviewNo) {
		log.info("ReplyServiceImpl getList() reviewNo : " + reviewNo);
		return mapper.getListWithPaging(cri, reviewNo);
	}

	@Override
	public int modify(ReviewReplyVO rvo) {
		log.info("ReplyServiceImpl modify() rvo : " + rvo);
		return mapper.update(rvo);
	}

	@Override
	public ReviewReplyVO get(Long replyNo) {
		log.info("ReplyServiceImpl get() replyNo : " + replyNo);
		return mapper.read(replyNo);
	}
}
