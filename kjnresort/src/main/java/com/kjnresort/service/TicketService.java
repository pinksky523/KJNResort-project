package com.kjnresort.service;

import java.util.List;

import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;

public interface TicketService {
	public List<TicketBuyVO> getList(Criteria cri); //getListWithPaging ¾¸
	public int getTotalCount(Criteria cri);
	
	public List<TicketBuyVO> getListUser(String id); //getListWithPaging ¾¸
	public int getTotalCountUser(Criteria cri, String id);
	
	public int register(TicketBuyVO ticket);
	public long getMaxTicketNo();
	
	public boolean modify(TicketVO tPrice);
	public boolean modifyStatus(Long ticketNo);
	public boolean modifyStatusUse(Long ticketNo);
	public boolean remove(Long ticketNo);
	public TicketBuyVO get(Long ticketNo);
	public MemberVO getMember(String id);
	public TicketVO getPrice();
	public TicketVO getPriceT();
	
	
}
