package com.kjnresort.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.TicketVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TicketMapperTest {
	@Setter(onMethod_ = @Autowired)
	private TicketMapper mapper;
	
	@Test
	public void readTests()  {
		TicketVO ticket = mapper.readPriceT();
		log.info(ticket);
	}
}
