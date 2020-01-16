package com.kjnresort.domain;

import java.util.Date;
import java.util.List;


import lombok.Data;

@Data
public class MemberVO {
	private String name;
	private String id;
	private String pw;				//비밀번호
	private String phoneNumber;		//핸드폰번호
	private String birth;			//생년월일
	private char gender;			//성별
	private String address;			//주소
	private int status;			//정지상태인지 일반상태인지
	private Date regDate;
	private List<AuthVO> authList;	
	
}