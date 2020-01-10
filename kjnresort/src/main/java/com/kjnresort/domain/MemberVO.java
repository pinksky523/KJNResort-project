package com.kjnresort.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private Date regDate;
	private Date updateDate;
	private boolean enabled;
	
	private List<AuthVO> authList;

}
