package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.TicketBuyVO;

public interface TicketMapper {
	public List<TicketBuyVO> getListWithPaging(Criteria cri);
	public List<TicketBuyVO> getList();
	public void insert(TicketBuyVO ticket);
	public int update(TicketBuyVO ticket);
	public int delete(Long ticketNo);
	public TicketBuyVO read(Long ticketNo);
}
