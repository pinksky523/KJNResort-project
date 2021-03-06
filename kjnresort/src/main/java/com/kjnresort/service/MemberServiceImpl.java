package com.kjnresort.service;	//이 패키지를 스프링이 자동스캔하도록 root-context.xml 설정

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjnresort.domain.AuthVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.ReviewVO;
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
		log.info("비밀번호 변경 서비스임플 진입");
		member.setPw(bcryptPasswordEncoder.encode(member.getPw()));
		return mapper.pwUpdate(member) == 1;
	}
	
	//마이페이지 조회
	@Transactional
	@Override
	public MemberVO mypageGet(MemberVO member) {
		log.info("마이페이지 조회 서비스임플 진입");
		
		return mapper.mypageRead(member);
	}
	
	//마이페이지 수정
	@Transactional
	@Override
	public boolean modifyMypage(MemberVO member) {
		
		log.info("마이페이지 수정 서비스 임플 진입");
		if(member.getPw() == "" || member.getPw() == null) {
			return mapper.mypageUpdate2(member);
		}
		else {
			member.setPw(bcryptPasswordEncoder.encode(member.getPw()));
			return mapper.mypageUpdate(member);
		}
	}
	
	
	//회원탈퇴
	@Transactional
	@Override
	public boolean remove(MemberVO member) {
		log.info("마이페이지 회원탈퇴 서비스임플 진입");
			
		return mapper.delete(member) == 1;
	}
	
	
	
	//내가 쓴 리뷰 목록 페이징
	@Transactional
	@Override
	public List<ReviewVO> myreviewList(@Param("id") String id, @Param("pageNum") int pageNum, @Param("amount") int amount) {
		log.info("내가 쓴 리뷰 목록 서비스임플 진입");
		return mapper.myreviewList(id, pageNum, amount);
	}
	
	//내가 쓴 리뷰 전체개수 가져오기
	@Transactional
	@Override
	public int getTotalMyReview(@Param("id") String id, Criteria cri) {
		log.info("내가 쓴 리뷰 전체개수 서비스임플 진입");
		
		return mapper.getTotalMyReview(id, cri);
	}
	
	
	//회원목록 페이징
	@Transactional
	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
		log.info("회원 목록 서비스임플 진입");
		return mapper.memberList(cri);
	}	
	
	//전체 회원 수 가져오기
	@Transactional
	@Override
	public int getTotalMember(Criteria cri) {
		return mapper.totalMemberCount(cri);
	}
		
		
	//회원 상세조회(관리자)
	@Transactional
	@Override
	public MemberVO getMember(String id) {
		log.info("회원 상세조회 서비스임플 진입");
		return mapper.readMember(id);
	}
	
	//회원 상태수정(관리자)
	@Transactional
	@Override
	public boolean statusModify(MemberVO member) {
		log.info("회원 상태수정 서비스임플 진입");
		log.info("회원 상태 값 체크 : " + member.getStatus());
		
		if(member.getStatus() == 0) {
			return mapper.statusNormal(member);
		} else {
			return mapper.statusBlock(member);
		}
	}
	
	//로그인
	@Transactional
	@Override
	public MemberVO get(String id) {
		return mapper.read(id);
	}
}
