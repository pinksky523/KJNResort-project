package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EventVO {
	private Long eventNo;					//이벤트 글 번호
	private String eventTitle;				//이벤트 제목
	private Date eventStart;				//이벤트 시작일자
	private Date eventEnd;					//이벤트 종료일자
	private Long viewCnt;					//이벤트 게시물 조회수
	private List<EventAttachVO> attachList;	//이벤트 이미지파일 리스트
	
}