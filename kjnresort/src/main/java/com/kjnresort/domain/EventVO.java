package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EventVO {
	private Long event_no;
	private String id;
	private String event_title;
	private Date event_start;
	private Date event_end;
	private Long view_cnt;
	private List<EventAttachVO> attachList;
	
}