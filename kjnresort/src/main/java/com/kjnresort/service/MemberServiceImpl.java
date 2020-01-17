package com.kjnresort.service;	//이 패키지를 스프링이 자동스캔하도록 root-context.xml 설정

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.EventAttachVO;
import com.kjnresort.domain.EventVO;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.ReviewAttachVO;
import com.kjnresort.mapper.EventAttachMapper;
import com.kjnresort.mapper.EventMapper;
import com.kjnresort.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//BoardService 인터페이스 구현
//어떤 식으로 remove하고 어떤 식으로 처리할 것인지
//mapper의 메서드를 불러

@Service
@Log4j
@AllArgsConstructor	//생성자 주입
public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper;

	
	@Override
	public MemberVO get(String id) {

		return mapper.read(id);
	}

	
	@Override
	public boolean modify(MemberVO member) {

		return mapper.update(member) == 1;
	}

	@Override
	public boolean remove(String id) {

		return mapper.delete(id) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<MemberVO> getList(Criteria cri) {

		return mapper.getListWithPaging(cri);
	}	
	
	@Transactional
	@Override
	public void register(MemberVO member) {
		log.info("회원가입 서비스임플 진입 : " + member);
		mapper.insert(member);
		log.info("회원정보 DB저장 완료");
		
	}

	@Transactional
	@Override
	public boolean idCheck(String id) {
		return mapper.idCheck(id)==1;
	}
	
	
}
