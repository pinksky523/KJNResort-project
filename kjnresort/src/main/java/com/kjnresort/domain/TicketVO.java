package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TicketVO {
	private Long ticketNo; //구매 번호
	private String buyDate; // 구매일시
	private String id;

	private Long liftAmount;
	private Long toolAmount;
	private boolean liftChoice;
	private boolean toolChoice;
	private int     review;
}
