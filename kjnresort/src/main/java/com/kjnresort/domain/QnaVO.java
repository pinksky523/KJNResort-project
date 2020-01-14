package com.kjnresort.domain;

import java.util.Date;

public class QnaVO { //큐엔에이 브이오
   public long qno;
   public String title;
   public String id;
   public String contents;
   public Date regDate;
   public String answer;
   public Date answerRegDate;
   

public long getQno() {
	return qno;
}
public void setQno(long qno) {
	this.qno = qno;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}

public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public void setAnswerRegDate(Date answerRegDate) {
	this.answerRegDate = answerRegDate;
}
public String getContents() {
	return contents;
}
public void setContents(String contents) {
	this.contents = contents;
}

public Date getRegDate() {
	return regDate;
}
public void setRegDate(Date regDate) {
	this.regDate = regDate;
}
public Date getAnswerRegDate() {
	return answerRegDate;
}
public String getAnswer() {
	return answer;
}
public void setAnswer(String answer) {
	this.answer = answer;
}



   
   
}
