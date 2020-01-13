package com.kjnresort.domain;

import lombok.Data;

@Data
public class EventAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;	
	private boolean boardType;		//후기게시판인지 이벤트게시판인지
	private Long eventNo;
}
