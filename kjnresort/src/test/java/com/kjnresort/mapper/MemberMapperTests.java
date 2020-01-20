package com.kjnresort.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjnresort.domain.MemberVO;
import com.kjnresort.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
//	@Test
//	public void testRead() {										// 댓글 read 테스트
//		MemberVO vo = mapper.read("admin90");
//		log.info(vo);
//		vo.getAuthList().forEach(authVO -> log.info(authVO));
//	}	
	
	
	
}
