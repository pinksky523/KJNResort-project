<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>all</title>
</head>
<body>

	<h1>/sample/all page</h1>
	
	<!-- �α����� �� ��� -->
	<sec:authorize access="isAnonymous()">
		<a href="/customLogin">�α���</a>
	</sec:authorize>
	<!-- �α����� ���� ���� ��� -->
	<sec:authorize access="isAuthenticated()">
		<a href="/customLogout">�α׾ƿ�</a>
	</sec:authorize>
	
</body>
</html>