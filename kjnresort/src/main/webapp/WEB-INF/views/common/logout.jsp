<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <script src="/resources/js/vendor/jquery-1.12.4.min.js"></script>
</head>
<body>
      <script>
         alert("로그아웃되었습니다.");
      </script>

   <%
      session.invalidate();
   %>
   <script>
      location.href="/";
   </script>
</body>
</html>