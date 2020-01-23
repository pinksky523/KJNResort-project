package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;

public interface TicketMapper {
	public List<TicketBuyVO> getListWithPaging(Criteria cri);
	public List<TicketBuyVO> getList();
	public int getTotalCount(Criteria cri);
	
	public void insert(TicketBuyVO ticket); //
	public int updateL(TicketVO tPrice); // insert¶û update Çò°¥¸®Áö ¸» °Í 
	public int updateStatus(TicketBuyVO ticket);
	public int delete(Long ticketNo);
	public TicketBuyVO read(Long ticketNo);
	public MemberVO readMember(String id);
	public TicketVO readPrice();
	public TicketVO readPriceT();
}
