package com.kjnresort.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	
	@Override
	public void handle(HttpServletRequest request,
			HttpServletResponse response, AccessDeniedException accessExcewption)
			throws IOException, ServletException {
		
		log.error("CustomAccessDeniedHandler handle().......");
		log.error("Redirect....");
		log.info("3333");
		//액세스 거부되었을 경우
		response.sendRedirect("/accessError");
	}
}
