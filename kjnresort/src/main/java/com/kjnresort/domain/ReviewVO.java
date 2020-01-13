package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Long	reviewNo;
	private String 	title;
	private String	contents;
	private Date	regdate;
	private Long    viewCnt;
	private String  status;
	private String  category;
	private String  id;
	private Long    grade;
	private List<ReviewAttachVO> attachList;
}
