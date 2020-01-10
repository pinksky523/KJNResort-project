<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>admin</title>
</head>
<body>
	<h1>/sample/admin page</h1>
	<h2>로그인한 관리자</h2>
	
	<ul>
		<li>[ principal ] : <sec:authentication property="principal"/></li>
		<li>[ MemberVO ] : <sec:authentication property="principal.mvo"/></li>
		<li>[ 사용자 이름 ] : <sec:authentication property="principal.mvo.userName"/></li>
		<li>[ 사용자 아이디 ] : <sec:authentication property="principal.username"/>,
								<sec:authentication property="principal.mvo.userid"/></li>
		<li>[ 사용자 권한 리스트 ] : <sec:authentication property="principal.mvo.authList"/></li>
	</ul>
	
	<a href="/customLogout">Logout</a>
</body>
</html>