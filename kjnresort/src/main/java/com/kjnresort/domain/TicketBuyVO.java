package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TicketBuyVO {
	private Long ticketNo; //구매 번호
	private String buyDate; // 구매일시
	private String id;

	private Long liftAmount; //수량이 0이면 미선택인것
	private Long toolAmount; //수량이 0이면 미선택인것
	private String status; //이용했는지 안했는지
	private int     review;
}
