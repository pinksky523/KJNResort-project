package com.kjnresort.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.kjnresort.domain.Criteria;
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
	public List<TicketBuyVO> getList() {
		log.info("getList------------");
		return mapper.getList();
	}

	@Override
	public boolean modify(TicketVO tVO) {
		log.info("modify------------");
		return mapper.updateL(tVO) == 1;
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
	public void register(TicketBuyVO ticket) {
		
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

}
