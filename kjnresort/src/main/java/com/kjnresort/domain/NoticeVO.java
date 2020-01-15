package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Long	noticeNo;			// 글 번호
	private String 	title;				// 제목
	private String	content;			// 내용
	private Date	regDate;			// 작성일시
	private Long 	viewCnt;			// 조회수
	private String	topCheck;			// 게시글 Top check
}

