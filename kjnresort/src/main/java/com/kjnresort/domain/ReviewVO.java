package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Long	reviewNo;
	private String 	title;
	private String	content;
	private Date	regdate;
	private Long    viewCnt;
	private Long    useNo; //사용번호 이걸로 구매번호나 예약번호 들어온다
	private String  category;
	private String  id;
	private Long    grade;
	private List<ReviewAttachVO> attachList;
}
