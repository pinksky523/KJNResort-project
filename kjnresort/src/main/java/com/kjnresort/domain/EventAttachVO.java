package com.kjnresort.domain;

import lombok.Data;

@Data
public class EventAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;	
	private Long eventNo;
}
