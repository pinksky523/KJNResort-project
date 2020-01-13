package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RecruitVO {
	private Long	recruitNo;			// 글 번호
	private String 	title;				// 제목
	private String	contents;			// 내용
	private Date	regDate;			// 작성일시
	private String	status;				// 상태(모집중, 마감)
	private String	deadLine;			// 접수기간
}
