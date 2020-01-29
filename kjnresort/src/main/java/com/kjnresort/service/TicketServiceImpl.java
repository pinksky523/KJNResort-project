package com.kjnresort.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;
import com.kjnresort.mapper.TicketMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class TicketServiceImpl implements TicketService{
	
	private TicketMapper mapper;
	
	@Override
	public List<TicketBuyVO> getList(Criteria cri) {
		log.info("getListWithPaging------------");
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("getTotalCount------------");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<TicketBuyVO> getListUser(String id) {
		log.info("getListWithPagingUser------------");
		return mapper.getListWithPagingUser(id);
	}

	@Override
	public int getTotalCountUser(Criteria cri, String id) {
		log.info("getTotalCountUser------------");
		return mapper.getTotalCountUser(cri, id);
	}

	@Override
	public boolean modify(TicketVO tPrice) {
		log.info("modify price------------");
		return mapper.updateL(tPrice) == 1;
	}

	@Override
	public boolean remove(Long ticketNo) {
		return false;
	}

	@Override
	public TicketBuyVO get(Long ticketNo) {
		log.info("get------------");
		return mapper.read(ticketNo);
	}

	@Override
	public TicketVO getPrice() {
		log.info("getPrice--------------------");
		return mapper.readPrice();
	}

	@Override
	public TicketVO getPriceT() {
		log.info("getPriceT--------------------");
		return mapper.readPriceT();
	}

	@Override
	public MemberVO getMember(String id) {
		log.info("getMember------------");
		return mapper.readMember(id);
	}

	@Override
	public boolean modifyStatus(Long ticketNo) {
		log.info("modify cancel------------");
		return mapper.updateStatus(ticketNo) == 1;
	}

	@Override
	public boolean modifyStatusUse(Long ticketNo) {
		log.info("modify use------------");
		return mapper.updateStatusUse(ticketNo) == 1;
	}

	@Override
	public int register(TicketBuyVO ticket) {
		log.info("register ------------- : " + ticket);
		
		return mapper.insert(ticket);
	}

	@Override
	public long getMaxTicketNo() {
		return mapper.getMaxTicketNo();
	}

}
