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
	private Date birth;
	private char gender;
	private String address;
	private boolean state;	//정지상태인지 일반상태인지
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;	
}