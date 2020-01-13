package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EventVO {
	private Long eventNo;
	private String writer;
	private String eventTitle;
	private Date eventStart;
	private Date eventEnd;
	private Long viewCnt;
	private List<EventAttachVO> attachList;
	
}