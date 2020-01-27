package com.kjnresort.mapper;

import java.util.List;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.TicketBuyVO;
import com.kjnresort.domain.TicketVO;

public interface TicketMapper {
	public List<TicketBuyVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	public List<TicketBuyVO> getListWithPagingUser(String id);
	public int getTotalCountUser(Criteria cri, String id);
	
	public int insert(TicketBuyVO ticket); //
	public long getMaxTicketNo();
	
	public int updateL(TicketVO tPrice); // insert랑 update 헷갈리지 말 것 
	public int updateStatus(Long ticketNo);
	public int updateStatusUse(Long ticketNo); // 상태 이용으로
	public int delete(Long ticketNo);
	public TicketBuyVO read(Long ticketNo);
	public MemberVO readMember(String id);
	public TicketVO readPrice();
	public TicketVO readPriceT();
}
