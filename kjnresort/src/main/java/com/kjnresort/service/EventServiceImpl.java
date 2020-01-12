package com.kjnresort.service;	//이 패키지를 스프링이 자동스캔하도록 root-context.xml 설정

import java.util.List;

import org.springframework.stereotype.Service;

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

	@Override
	public void register(EventVO event) {

		mapper.insertSelectKey(event);
	}
	
	@Override
	public EventVO get(Long event_no) {

		return mapper.read(event_no);
	}

	
	@Override
	public boolean modify(EventVO event) {

		return mapper.update(event) == 1;
	}

	@Override
	public boolean remove(Long event_no) {

		return mapper.delete(event_no) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<EventVO> getList(Criteria cri) {

		return mapper.getListWithPaging(cri);
	}	
	
	
	@Override
	public List<EventAttachVO> getAttachList(Long event_no) {
		
		return attachMapper.findByEventNo(event_no);
	}
	
	
}
