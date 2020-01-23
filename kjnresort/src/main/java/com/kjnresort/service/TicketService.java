package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

public interface TicketService {
	public List<TicketBuyVO> getList(Criteria cri); //getListWithPaging ¾¸
	public List<TicketBuyVO> getList();
	public int getTotalCount(Criteria cri);
	
	public boolean modify(TicketVO tPrice);
	public boolean modifyStatus(TicketBuyVO ticket);
	
	public boolean remove(Long ticketNo);
	public TicketBuyVO get(Long ticketNo);
	public MemberVO getMember(String id);
	public TicketVO getPrice();
	public TicketVO getPriceT();
	public void register(TicketBuyVO ticket);
	
}
