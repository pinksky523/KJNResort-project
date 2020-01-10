package com.kjnresort.aop;

import java.util.Arrays;
import java.util.Date;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		log.info("START : " + new Date().toLocaleString());
		log.info("TAGRGET " + pjp.getTarget());
		log.info("PARAM : " + Arrays.toString(pjp.getArgs()));
		
		Object obj = null;
		try {
			Thread.sleep(1000);
			obj = pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		log.info("END : " + new Date().toLocaleString());
		log.info("소요 시간(초) : " + (end-start)/1000 );
		return obj;		
	}
	
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))",
				   throwing = "exception")
	public void logException(Exception exception) {
		log.info("logException() ----------------------------------");
		log.info("exception : " + exception);
	}

	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String))"
			+ " && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("logBeforeWithParam() ----------------------------------");
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
	}
	
	@After("execution(* org.zerock.service.SampleService*.*(..))")
	public void logAfter() {
		log.info("logAfter() ----------------------------------");
	}
}















