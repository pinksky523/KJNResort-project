package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;
@Data
public class QnaVO { //큐엔에이 브이오
	private long qnaNo;
	private String title;
	private String id;
	private String contents;
	private Date regDate;
	private String answer;
	private Date answerRegDate;
   

}
