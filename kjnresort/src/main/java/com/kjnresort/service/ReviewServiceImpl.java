package com.kjnresort.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
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
		log.info("getTotalCount------------");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<ReviewVO> getList(Criteria cri) {
		log.info("getListWithPaging------------");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public boolean modify(ReviewVO review) {
		boolean result = mapper.update(review) == 1;	//업데이트 처리
		return result;
	}

	@Override
	public boolean remove(Long reviewNo) {
		log.info("remove....... : " + reviewNo);
		return mapper.delete(reviewNo) == 1;
	}

	@Override
	public ReviewVO get(Long reviewNo) {
		log.info("get------------");
		return mapper.read(reviewNo);
	}

	@Override
	public void register(ReviewVO review) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	//내가 쓴 후기 전체개수
	@Override
	public int getMyTotalCount(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount) {
		log.info("getMyTotalCount id 체크 : " + id);
		log.info("getMyTotalCount pageNum 체크 : " + pageNum);
		log.info("getMyTotalCount amount 체크 : " + amount);
		
		log.info("getTotalCount------------");
		return mapper.getMyTotalCount(id, pageNum, amount);
	}

	//내가 쓴 후기 목록
	@Override
	public List<ReviewVO> getMyList(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount) {
		log.info("getMyList id 체크 : " + id);
		log.info("getMyList pageNum 체크 : " + pageNum);
		log.info("getMyList amount 체크 : " + amount);
		log.info("getListWithPaging------------");
		return mapper.getMyListWithPaging(id, pageNum, amount);
	}
	
	

}
