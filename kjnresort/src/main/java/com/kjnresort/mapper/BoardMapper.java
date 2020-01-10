package com.kjnresort.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjnresort.domain.BoardVO;
import com.kjnresort.domain.Criteria;

public interface BoardMapper {
	public void updateReplyCnt(@Param("bno") Long bno,
							   @Param("amount") int amount);
	
	
	public int getTotalCount(Criteria cri);
	public List<BoardVO> getListWithPaging(Criteria cri);

//	@Select("SELECT * FROM tbl_board WHERE bno > 0")
	public List<BoardVO> getList();
	
	public void insertSelectKey(BoardVO board);							
	public void insert(BoardVO board);
	public int update(BoardVO board);
	public int delete(Long bno);
	public BoardVO read(Long bno);

}






