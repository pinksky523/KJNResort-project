package com.kjnresort.service;	//이 패키지를 스프링이 자동스캔하도록 root-context.xml 설정

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
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

	@Autowired 
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<MemberVO> getList(Criteria cri) {

		return mapper.getListWithPaging(cri);
	}	
	
	//////////////////////////////////////////////////
	
	
	//회원가입
	@Transactional
	@Override
	public void register(MemberVO member) {
		log.info("회원가입 서비스임플 진입 : " + member);
		member.setPw(bcryptPasswordEncoder.encode(member.getPw()));
		mapper.insert(member);
		log.info("회원정보 DB저장 완료");
	}

	//회원권한등록
	@Transactional
	@Override
	public void registerAuth(AuthVO auth) {
		log.info("회원권한등록 서비스임플 진입 : " +  auth);
		mapper.insertAuth(auth);
		log.info("회원권한 DB저장 완료");
	}
	
	//회원가입 아이디 중복확인
	@Transactional
	@Override
	public MemberVO idCheck(String id) {
		log.info("id중복확인 서비스임플 진입");
		return mapper.idCheck(id);
	}
	
	
	//회원가입 아이디 중복확인
	@Transactional
	@Override
	public MemberVO phoneNumberCheck(String phoneNumber) {
		log.info("phoneNumber중복확인 서비스임플 진입");
		return mapper.phoneNumberCheck(phoneNumber);
	}
		
		
	//아이디찾기
	@Transactional
	@Override
	public String findId(String name, String phoneNumber) {
		log.info("아이디찾기 서비스임플 진입");
		return mapper.findId(name, phoneNumber);
	}
	
	//비밀번호찾기
	@Transactional
	@Override
	public String findPw(String id, String name, String phoneNumber) {
		log.info("비밀번호찾기 서비스임플 진입");
		return mapper.findPw(id, name, phoneNumber);
	}
	
	
	//비밀번호변경 
	@Transactional
	@Override
	public boolean pwModify(MemberVO member) {
		member.setPw(bcryptPasswordEncoder.encode(member.getPw()));
		return mapper.pwUpdate(member) == 1;
	}
	
	//마이페이지 조회
	@Transactional
	@Override
	public MemberVO mypageGet(MemberVO member) {

		return mapper.mypageRead(member);
	}
	
	//로그인
	@Transactional
	@Override
	public MemberVO get(String id) {
		return mapper.read(id);
	}
}
