package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;
@Data
public class QnaVO { //큐엔에이 브이오
	public long qnaNo;
	public String title;
	public String id;
	public String contents;
	public Date regDate;
	public String answer;
	public Date answerRegDate;
   

}
