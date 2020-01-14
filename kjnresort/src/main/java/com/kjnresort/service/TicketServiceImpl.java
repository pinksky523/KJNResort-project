package com.kjnresort.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.TicketBuyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class TicketServiceImpl implements TicketService{@Override
	public List<TicketBuyVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TicketBuyVO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(TicketBuyVO ticket) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long ticketNo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public TicketBuyVO get(Long ticketNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void register(TicketBuyVO ticket) {
		// TODO Auto-generated method stub
		
	}

}
