package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String name;
	private String id;
	private String pw;
	private String phoneNumber;
	private Date birth;				//생년월일
	private char gender;			//성별
	private String address;			//주소
	private boolean status;			//정지상태인지 일반상태인지
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;	
}