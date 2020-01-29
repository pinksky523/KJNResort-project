package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EventVO {
	private Long eventNo;					//이벤트 글 번호
	private String id;						//이벤트 작성자(관리자)
	private String title;					//이벤트 제목
	private String eventStart;				//이벤트 시작일자
	private String eventEnd;				//이벤트 종료일자
	private Long viewCnt;					//이벤트 게시물 조회수
	private List<EventAttachVO> attachList;	//이벤트 이미지파일 리스트
	private int rn;							//게시글 행번호
}