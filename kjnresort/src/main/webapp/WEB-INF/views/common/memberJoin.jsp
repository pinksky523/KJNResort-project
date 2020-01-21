<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css"/>


</head>
<body class="contents">
	<h1>회원가입</h1>
	<hr>
	<form id="joinForm" name="frm" method="post" action="/common/register">
   <table width="100%" style="padding:5px 0 5px 0; ">
      
       <tr>
         <th>아이디</th>
         <td class="chkMessage">
        <input type="text" class="form-control" name="id" id="inputId" style="width: 35%" onkeyup="idCheck()">
        <span id="idChk"></span></td>
       </tr>
       <tr>
         <th> 이름</th>
         <td><input type="text" class="form-control" name="name" id="inputName" style="width: 35%" onkeyup="nameCheck()">
      	 <span id="nameChk"></span></td>
      </tr>
       <tr>
         <th>비밀번호</th>
         <td><input type="password" class="form-control" name="pw1" id="inputPassword" style="width: 35%" onkeyup="passwordCheck1()">
      	 <span id="pwChk1"></span></td>
       </tr>
       <tr>
         <th>비밀번호 확인</th>
         <td><input type="password" class="form-control" name="pw" id="inputPasswordChk"  style="width: 35%" onkeyup="passwordCheck2()">
		 <span id="pwChk2"></span></td>
       </tr>
        <tr>
         <th>핸드폰번호</th>
         <td><input type="text" class="form-control" name="phoneNumber" id="inputPhoneNumber" style="width: 35%" onkeyup="phoneCheck()">
       	 <span id="phoneChk"></span></td>
       </tr>
        <tr>
         <th>생년월일</th>
         <td><input type="date" class="form-control" name="birth" id="inputBirth" style="width: 35%"></td>
       </tr>
       <tr>
         <th>성별</th>
           <td class="s">
               <input type="radio" name="gender" value="M" checked>남
               <input type="radio" name="gender" value="F">여
            </td>
         </tr>
         
         <tr>
         <tr>
         <th>주소</th>
         <td><input type="text" class="form-control" name="address" id="inputAddress"></td>
       </tr>
           <tr>
             <td colspan="2" align="center">
		   	  <button type="button" class="btn btn-secondary" id="joinCancel" onclick="location.href='/common/home'">취소</button>
		      <button type="button" class="btn btn-primary" id="joinResult" onclick="confirm()">가입완료</button>
            </td>
           </tr>
           </table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          </form>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/idCheck.js"></script>
<script>
var nameChk = false;
var idChk = false;
var pwChk1 = false;
var pwChk2 = false;
var phoneChk = false;
var idDBChk = false;
var x = document.getElementById("inputBirth").required;

//이름 확인
function nameCheck(){
	
	var name = document.getElementById('inputName').value;
	
	if(name.length == 0 || name == "") {
		document.getElementById('nameChk').innerHTML="";
		nameChk = false;
	}
	else if(! /^[가-힣]{2,6}$/.test(name)) {
		document.getElementById('nameChk').innerHTML="<b><font color=red size=1px>한글 2~6글자 이내로 입력해주세요 (자음/모음만 입력불가)</font></b>"
		nameChk = false;
	} else {
		document.getElementById('nameChk').innerHTML="";
		nameChk = true;
	}
}


//아이디 확인
function idCheck(){
	var id = document.getElementById('inputId').value;
	
	
	if(id.length == 0 || id == "") {
		document.getElementById('idChk').innerHTML = "";
		idChk = false;
	} else if(((id.length < 5) || (id.length > 15))){
		document.getElementById('idChk').innerHTML = "<b><font color=red size=1px>5 - 15자 이내로 입력해주세요.</font></b>"
		idChk = false;
	} else if(!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,15}$/.test(id)){
		document.getElementById('idChk').innerHTML = "<b><font color=red size=1px>영어 소문자, 숫자를 조합하여 입력해주세요.</font></b>"
		idChk = false;
	} else {
		
		//아이디 중복확인
	    idCheckService.getId(id, function(result){
	       if(id == result.id){
	    	   document.getElementById('idChk').innerHTML = "<b><font color=red size=1px>이미 사용중인 아이디입니다.</font></b>";
				idChk = false;
	     	  idDBChk = false;
	       } else{
	    	   document.getElementById('idChk').innerHTML = "<b><font color='green' size=1px>사용가능한 아이디입니다.</font></b>";
				idChk = true;
	     	  idDBChk = true;
	       }
	    });
		
		
	}
}



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

//핸드폰 확인
function phoneCheck(){
	var phoneNumber = document.getElementById('inputPhoneNumber').value;
	
	
	if(phoneNumber.length == 0 || phoneNumber == "") {
		document.getElementById('phoneChk').innerHTML="";
		phoneChk = false;
	}
	else if(!/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/.test(phoneNumber)) {
		document.getElementById('phoneChk').innerHTML="<b><font color=red size=1px>하이픈(-) 포함 13자 이내로 입력해주세요.</font></b>"
		phoneChk = false;
	} else {
		document.getElementById('phoneChk').innerHTML="";
		phoneChk = true;
	}
}


//확인 후 submit
function confirm() {
	
	var birthChk = document.getElementById("inputBirth").value;
	var addressChk = document.getElementById("inputAddress").value;
	
	if( nameChk==true && idChk==true && idDBChk && pwChk1==true && pwChk2==true && phoneChk==true && birthChk!="" && addressChk!="") {
		document.frm.submit();
	}
	else if((idChk == false) || (idDBChk == false)) {
		alert('아이디를 확인해주세요');
		document.frm.id.focus();
	} else if(nameChk == false ) {
		alert('이름을 확인해주세요');
		document.frm.name.focus();
	} else if(pwChk1 == false) {
		alert('비밀번호를 확인해주세요');
		document.frm.pw1.focus();
	} else if(pwChk2 == false) {
		alert('비밀번호를 확인해주세요');
		document.frm.pw.focus();
	} else if(phoneChk == false) {
		alert('핸드폰번호를 확인해주세요');
		document.frm.phoneNumber.focus();
	} else if(birthChk == null || birthChk === "") {
		alert('생년월일을 확인해주세요');
		document.frm.birth.focus();
	} else if(addressChk == null || addressChk == "") {
		alert('주소를 확인해주세요');
		document.frm.address.focus();
	}
}

</script>
</body>
</html>