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
		
		//ROLE_ADMIN이면 /sample/admin으로 리다이렉트
		if(roleList.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		}
		
		//ROLE_MEMBER이면 /sample/member로 리다이렉트
		if(roleList.contains("ROLE_MEMBER")) {
			log.info("");
			response.sendRedirect("/sample/member");
			return;
		}
		response.sendRedirect("/");
	}

}
