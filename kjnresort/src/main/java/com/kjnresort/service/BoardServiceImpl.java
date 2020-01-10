package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.BoardAttachVO;
import com.kjnresort.domain.BoardVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.mapper.BoardAttachMapper;
import com.kjnresort.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount .......");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with paging.......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.......");
		return mapper.getList();
	}
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register....... : " + board);
		mapper.insertSelectKey(board);
		List<BoardAttachVO> attachList = board.getAttachList();

		// 첨부파일이 없으면 중단
		if(attachList == null || attachList.size() <= 0) {
			return;
		}
		// 첨부파일이 있으면 tbl_attach에 insert 
		attachList.forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify....... : " + board);
		attachMapper.deleteAll(board.getBno());						// 기존 첨부 파일 삭제
		boolean modifyResult = mapper.update(board) == 1;			// 업데이트 처리
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach ->{				// 업데이트에 성공한 경우 첨부파일이 있으면
				attach.setBno(board.getBno());						// 첨부파일 등록 처리
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove....... : " + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get.......");
		return mapper.read(bno);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno : " + bno);
		return attachMapper.findByBno(bno);
	}
}















