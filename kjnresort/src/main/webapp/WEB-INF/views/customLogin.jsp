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
    	<form role="form">
			<fieldset>
				<h3>로그인</h3>
				<hr style="border: solid 2px lightgray">
				<div class="form-group">
                    <input type="text" name="email" id="email" class="form-control input-lg" placeholder="아이디">
				</div>
				<div class="form-group">
                    <input type="password" name="password" id="password" class="form-control input-lg" placeholder="비밀번호">
				</div>
					<a href="/member/findId" class="btn btn-link pull-left">아이디 찾기</a>
					<a href="/member/findPw" class="btn btn-link pull-right">비밀번호 찾기</a>
				<br><hr>
				
				<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
                        <input type="submit" class="btn btn-lg btn-success btn-block" value="로그인">
					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						<a href="/member/register" class="btn btn-lg btn-primary btn-block">회원가입</a>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</div>
</div>
<script>
$(function(){	
	var result = '<c:out value="${result}"/>';	
	
	//result 값이 있는지 확인하는 함수 호출
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	
	function checkModal(){
		//값이 없으면 리턴시킴
		if(result === '' || history.state){
			return;
		}
		
		//값이 있으면 메시지 띄우기
		if(result !== ''){
			alert(result);
			console.log("메세지가 존재하면 alert 띄워야될텐데");
			
		}
		
	}
});
	

</script>
</body>

</html>
