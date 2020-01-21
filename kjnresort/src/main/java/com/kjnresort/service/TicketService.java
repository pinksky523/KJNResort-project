package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;
import com.kjnresort.domain.Criteria;

public interface TicketService {
	public List<TicketBuyVO> getList(Criteria cri);
	public List<TicketBuyVO> getList();
	
	public boolean modify(TicketVO tVO);
	public boolean remove(Long ticketNo);
	public TicketBuyVO get(Long ticketNo);
	public TicketVO getPrice();
	public TicketVO getPriceT();
	public void register(TicketBuyVO ticket);
}
