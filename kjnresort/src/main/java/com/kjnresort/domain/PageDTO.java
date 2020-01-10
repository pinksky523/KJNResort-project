package com.kjnresort.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		//끝 페이지 계산 - 한 화면에 페이지 번호 10개를 출력한다고 가정
		endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		startPage = this.endPage - 9;	//시작 페이지 계산
		
		//실제 끝 페이지 계산
		int realEnd = (int)(Math.ceil( (total * 1.0) / cri.getAmount()));
		
		if(realEnd <= endPage) {	//끝 페이지가 실제 페이지보다 큰 경우
			endPage = realEnd;
		}
		
		prev = startPage > 1;		//이전 페이지 여부
		next = endPage < realEnd;	//다음 페이지 여부
	}
}















