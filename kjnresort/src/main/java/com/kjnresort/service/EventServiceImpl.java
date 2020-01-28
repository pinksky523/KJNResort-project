package com.kjnresort.service;	//이 패키지를 스프링이 자동스캔하도록 root-context.xml 설정

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;
import com.kjnresort.mapper.EventAttachMapper;
import com.kjnresort.mapper.EventMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//BoardService 인터페이스 구현
//어떤 식으로 remove하고 어떤 식으로 처리할 것인지
//mapper의 메서드를 불러

@Service
@Log4j
@AllArgsConstructor	//생성자 주입
public class EventServiceImpl implements EventService {
	private EventMapper mapper;
	private EventAttachMapper attachMapper;

	
	//이벤트 게시글 목록
	@Override
	public List<EventVO> getList(Criteria cri) {
		log.info("이벤트 게시글 목록 서비스임플 진입");
		return mapper.getListWithPaging(cri);
	}
	
	//이벤트 게시글 전체개수 가져오기
	@Override
	public int getTotal(Criteria cri) {
		log.info("이벤트 게시글 전체개수 가져오기 서비스임플 진입");
		return mapper.getTotalCount(cri);
	}
	
	//이벤트 게시글 등록
	@Transactional
	@Override
	public void register(EventVO event) {
		log.info("이벤트 게시글 등록 서비스임플 진입");
		mapper.insert(event);
		
		//첨부파일이 없으면 중단(그냥 return)
		if(event.getAttachList() == null || event.getAttachList().size() <= 0) {
			return;
		}
		
		//t_event에 게시물을 등록하면, eventNo를 가져와서 t_event_attach 테이블에도 넣음
		event.getAttachList().forEach(attach -> {
			
			attach.setEventNo(event.getEventNo());
			
			attachMapper.insert(attach);
		});
	}
	
	
	//이벤트 게시글 상세조회
	@Override
	public EventVO get(Long eventNo) {
		log.info("이벤트 게시글 상세조회 서비스임플 진입");
		return mapper.read(eventNo);
	}
	
	//첨부파일 리스트
	@Override
	public List<EventAttachVO> getAttachList(Long eventNo) {
		log.info("이벤트 게시글 첨부파일목록 서비스임플 진입");
		return attachMapper.findByEventNo(eventNo);
	}
	
	
	//이벤트 게시글 수정
	@Override
	public boolean modify(EventVO event) {
		log.info("이벤트 게시글 수정 서비스임플 진입");
		
		attachMapper.deleteAll(event.getEventNo());
		boolean modifyResult = mapper.update(event) == 1;
		
		if(modifyResult && event.getAttachList() != null && event.getAttachList().size() > 0) {
			event.getAttachList().forEach(attach -> {
				attach.setEventNo(event.getEventNo());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
		
		
	}
	
	
	//이벤트 게시글 삭제
	@Transactional
	@Override
	public boolean remove(Long eventNo) {
		log.info("이벤트 게시글 삭제 서비스임플 진입");
		attachMapper.deleteAll(eventNo);
		
		return mapper.delete(eventNo) == 1;
	}
	
	//이벤트 게시글 조회수 업데이트
	@Transactional
	@Override
	public boolean updateViewCnt(Long eventNo) {
		log.info("조회수 업데이트 서비스임플 진입");
		
		return mapper.updateViewCnt(eventNo) == 1;
	}
		
		
}
