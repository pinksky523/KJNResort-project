package com.kjnresort.domain;

import lombok.Data;

@Data
public class TicketBuyVO {
	private Long ticketNo; //구매 번호
	private String id;
	private String type; //리프트인지 장비인지
	private String buyDate; // 구매일시
	private Long liftAmount; //수량이 0이면 미선택인것
	private Long toolAmount; //수량이 0이면 미선택인것
	private String status; //이용했는지 안했는지 (0이면 구매, 1이면 구매취소, 2면 이용)
	private int     review; //0 미등록 1 등록
}
