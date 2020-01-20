<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>로그인</title>
	<link rel="stylesheet" href="/resources/css/common.css"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<body class="contents">
<div class="container">
<div class="row">
    <div class="col-lg-5 col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    	<form role="form" method="post" action="/login">
			<fieldset>
				<h3>로그인</h3>
				<hr style="width: 100%; border: solid 2px lightgray;">
				<div class="form-group">
                    <input type="text" name="username" id="inputId" class="form-control input-lg" placeholder="아이디" required autofocus>
				</div>
				<div class="form-group">
                    <input type="password" name="password" id="inputPassword" class="form-control input-lg" placeholder="비밀번호" required>
				</div>
					<a href="/common/findId" class="btn btn-link pull-left">아이디 찾기</a>
					<a href="findPw" class="btn btn-link pull-right">비밀번호 찾기</a>
				<br><hr style="width: 100%">
				
				<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
						<a href="memberJoin" class="btn btn-lg btn-primary btn-block">회원가입</a>
					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
                        <input type="submit" class="btn btn-lg btn-success btn-block" value="로그인">
					</div>
				</div>
			</fieldset>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
</div>
</div>
<script>
$(function(){	
	var msg = '<c:out value="${msg}"/>';	
	
	//result 값이 있는지 확인하는 함수 호출
	checkModal(msg);
	history.replaceState({}, null, null);
	
	$(".btn-success").on("click", function(e){
		e.preventDefault();
		$("form").submit();
	});
	
	
	//메세지가 존재하면 alert창 띄우기
	function checkModal(){
		//값이 없으면 리턴시킴
		if(msg === '' || history.state){
			return;
		}
		
		//값이 있으면 메시지 띄우기
		if(msg !== ''){
			alert(msg);
		}
		
	}
});
	

</script>
</body>

</html>
