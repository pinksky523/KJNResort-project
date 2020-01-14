package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.ReviewVO;
import com.kjnresort.mapper.ReviewAttachMapper;
import com.kjnresort.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//수정할거 해야함
@Service
@Log4j
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService{
	
	private ReviewMapper mapper;
	private ReviewAttachMapper attachMapper;
	
	@Override
	public List<ReviewAttachVO> getAttachList(Long reviewNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReviewVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(ReviewVO review) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long reviewNo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ReviewVO get(Long reviewNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void register(ReviewVO review) {
		// TODO Auto-generated method stub
		
	}

}
