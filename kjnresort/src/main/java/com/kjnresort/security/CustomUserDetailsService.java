package com.kjnresort.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kjnresort.domain.MemberVO;
import com.kjnresort.mapper.MemberMapper;
import com.kjnresort.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	 @Override 
	 public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException { 
	 log.info("2222");
	 log.info("Load User By UserName : " + username); 
	 MemberVO mvo = memberMapper.read(username); 
	 log.info("queried by member mapper : " + mvo);
	 return mvo == null ? null : new CustomUser(mvo); }
	 

}
