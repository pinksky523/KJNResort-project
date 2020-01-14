package com.kjnresort.domain;

import lombok.Data;

@Data
public class TicketVO {
	public String type;//리프트권, 장비
	public Long   price;//가격
}
