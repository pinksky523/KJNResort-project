package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewReplyVO {
	private Long replyNo;
	private Long reviewNo;
	private String reply;
	private String id;
	private Date replyDate;
}
