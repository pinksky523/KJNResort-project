package com.kjnresort.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.warn("CustomLoginSuccessHandler login success");
		//사용자 권한을 리스트에 저장
		List<String> roleList = new ArrayList<>();
		authentication.getAuthorities().forEach(authority ->  {
			roleList.add(authority.getAuthority());
		});
		
		log.warn("ROLE_NAMES : " + roleList);
		
		//ROLE_ADMIN이면 /admin/adminMain으로 리다이렉트
		if(roleList.contains("ROLE_ADMIN")) {
			log.info("관리자 권한으로 로그인");
			response.sendRedirect("/admin/adminMain");
			return;
		}
		
		//ROLE_MEMBER이면 /common/commonMain로 리다이렉트
		if(roleList.contains("ROLE_MEMBER")) {
			log.info("일반회원 권한으로 로그인");
			response.sendRedirect("/common/commonMain");
			return;
		}
		response.sendRedirect("/");
	}

}
