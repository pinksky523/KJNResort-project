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

    <title>비밀번호 변경</title>
	<link rel="stylesheet" href="/resources/css/common.css"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<body class="contents">
<div class="container">
<div class="row">
    <div class="col-lg-5 col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    	<form role="form" name="frm" method="post" action="/common/pwModify">
			<fieldset>
				<h3>비밀번호 변경</h3>
				<hr style="width: 100%; border: solid 2px lightgray;">
				<label>새 비밀번호</label>
				<div class="form-group">
                    <input type="password" name="pw1" id="inputPassword" class="form-control input-lg" placeholder="비밀번호" onkeyup="passwordCheck1()" required autofocus>
					<span id="pwChk1"></span>
				</div>
				<br>
				<label>새 비밀번호 확인</label>
				<div class="form-group">
                    <input type="password" name="pw" id="inputPasswordChk" class="form-control input-lg" placeholder="비밀번호 확인" onkeyup="passwordCheck2()" required>
					<span id="pwChk2"></span>
				</div>
				
				<br><hr style="width: 100%">
				
				<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
                        <input type="button" class="btn btn-lg btn-secondary btn-block" onclick="location.href='/common/findPw'" value="취소">
					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						<input type="button" class="btn btn-lg btn-warning btn-block" onclick="confirm()" value="변경">
					</div>
				</div>
			</fieldset>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<input type="hidden" name="id" value="${id}">
		</form>
	</div>
</div>
</div>
<script>
var pwChk1 = false;
var pwChk2 = false;
var msg = '<c:out value="${msg}"/>';	
	
	
	
	//비밀번호 확인
	function passwordCheck1(){
		passwordCheck2();
		
		var pw = document.getElementById('inputPassword').value;
		if(pw.length == 0 || pw == "") {
			document.getElementById('pwChk1').innerHTML="";
			pwChk1 = false;
		} else if(((pw.length < 8) || (pw.length > 15))){
			document.getElementById('pwChk1').innerHTML="<b><font color=red size=1px>8 - 15자 이내로 입력해주세요.</font></b>"
			pwChk1 = false;
		} else if(!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{8,15}$/.test(pw)){
			document.getElementById('pwChk1').innerHTML="<b><font color=red size=1px>영어 소문자, 숫자를 조합하여 입력해주세요.</font></b>"
			pwChk1 = false;
		} else {
			document.getElementById('pwChk1').innerHTML="<b><font color='green' size=1px>사용가능한 비밀번호입니다.</font></b>";
			pwChk1 = true;
		}
	}

	//비밀번호 확인
	function passwordCheck2(){
		var pw = document.getElementById('inputPassword').value;
		var pwChk = document.getElementById('inputPasswordChk').value;
		
		if(pw != pwChk){
			document.getElementById('pwChk2').innerHTML="<b><font color=red size=1px>비밀번호가 일치하지 않습니다.</font></b>"
			pwChk2 = false;
		} else if(pw == pwChk){
			document.getElementById('pwChk2').innerHTML="<b><font color='green' size=1px>비밀번호가 일치합니다.</font></b>"
			pwChk2 = true;
		}
	}
	
	
	//확인 후 submit
	function confirm() {
		if(pwChk1==true && pwChk2==true) {
			document.frm.submit();
		} else if(pwChk1 == false) {
			alert('비밀번호를 확인해주세요');
			document.frm.pw1.focus();
		} else if(pwChk2 == false) {
			alert('비밀번호를 확인해주세요');
			document.frm.pw.focus();
		} 
	}
	
	
	
	//result 값이 있는지 확인하는 함수 호출
	checkModal(msg);
	history.replaceState({}, null, null);
	
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
	

</script>
</body>

</html>
