package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewReplyVO {
//	private Long rno;
//	private Long bno;
	private Long replyNo;
	private Long reviewNo;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
