package com.kjnresort.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ApplianceVO {
	private Long	recruitNo;			// 모집공고 번호
	private Long	applianceNo;		// 지원자 번호
	private String 	id;					// 아이디
	private String 	name;				// 이름
	private String 	phoneNumber;		// 핸드폰 번호
	private String 	address;			// 주소
	private String	career;				// 이력
	private String	introduction;		// 자기소개
	private String	status;				// 상태(임시저장, 제출)
	private Date	regDate;			// 제출일
}
