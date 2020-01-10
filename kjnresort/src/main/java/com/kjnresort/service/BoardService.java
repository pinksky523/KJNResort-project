package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.BoardAttachVO;
import com.kjnresort.domain.BoardVO;
import com.kjnresort.domain.Criteria;

public interface BoardService {
	public List<BoardAttachVO> getAttachList(Long bno);
	public int getTotalCount(Criteria cri);
	public List<BoardVO> getList(Criteria cri);
	public List<BoardVO> getList();
	
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public BoardVO get(Long bno);
	public void register(BoardVO board);
}
