package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.TicketVO;

public interface TicketMapper {
	public List<TicketVO> getListWithPaging(Criteria cri);					
	public void insert(TicketVO ticket);
	public int update(TicketVO ticket);
	public int delete(Long ticketNo);
	public TicketVO read(Long ticketNo);
}
