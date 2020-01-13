package com.kjnresort.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
    
	public Criteria( ) {
		this(1, 10);	//기본 페이지 번호는 1번, 갯수는 10개로 설정
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//링크 생성 처리
	public String getListlink() {
		UriComponentsBuilder builder
		= UriComponentsBuilder.fromPath("")
							  .queryParam("pageNum", pageNum)
							  .queryParam("amount", amount)
							  .queryParam("type", type)
							  .queryParam("keyword", keyword);
		return builder.toUriString();
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}









