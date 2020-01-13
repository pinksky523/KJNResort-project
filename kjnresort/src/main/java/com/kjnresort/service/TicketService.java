package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.TicketVO;
import com.kjnresort.domain.Criteria;

public interface TicketService {
	public List<TicketVO> getList(Criteria cri);
	public List<TicketVO> getList();
	
	public boolean modify(TicketVO ticket);
	public boolean remove(Long ticketNo);
	public TicketVO get(Long ticketNo);
	public void register(TicketVO ticket);
}
