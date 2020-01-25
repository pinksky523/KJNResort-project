<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

	<h2>회원가입</h2>
	<hr>
	<form id="joinForm" name="frm" method="post" action="/common/register">
   <table width="100%" style="padding:5px 0 5px 0; table-layout: fixed;">
      
       <tr>
         <th>아이디</th>
         <td><input type="text" class="form-control" name="id" id="inputId" onkeyup="idCheck()"></td>
       <td class="chkMessage"><span id="idChk"></span></td>
       </tr>
       <tr>
         <th>이름</th>
         <td><input type="text" class="form-control" name="name" id="inputName" onkeyup="nameCheck()"></td>
      	 <td class="chkMessage"><span id="nameChk"></span></td>
      </tr>
       <tr>
         <th>비밀번호</th>
         <td><input type="password" class="form-control" name="pw1" id="inputPassword" onkeyup="passwordCheck1()"></td>
      	 <td class="chkMessage"><span id="pwChk1"></span></td>
       </tr>
       <tr>
         <th>비밀번호 확인</th>
         <td><input type="password" class="form-control" name="pw" id="inputPasswordChk" onkeyup="passwordCheck2()"></td>
		 <td class="chkMessage"><span id="pwChk2"></span></td>
       </tr>
        <tr>
         <th>핸드폰번호</th>
         <td><input type="text" class="form-control" name="phoneNumber" id="inputPhoneNumber" onkeyup="phoneCheck()"></td>
       	 <td class="chkMessage"><span id="phoneChk"></span></td>
       </tr>
        <tr>
         <th>생년월일</th>
         <td><input type="date" class="form-control" name="birth" id="inputBirth" ></td>
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
         <td><input type="text" class="form-control" name="address" id="inputAddress" style="width: 150%"></td>
       </tr>
           <tr>
             <td colspan="3" align="center">
		   	  <button type="button" class="btn btn-secondary" id="joinCancel" onclick="location.href='/common/home'">취소</button>
		      <button type="button" class="btn btn-primary" id="joinResult" onclick="confirm()">가입완료</button>
            </td>
           </tr>
           </table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          </form>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/joongBokCheck.js"></script>
<script>
var nameChk = false;
var idChk = false;
var pwChk1 = false;
var pwChk2 = false;
var phoneChk = false;

//이름 확인
function nameCheck(){
	
	var name = document.getElementById('inputName').value;
	
	if(name.length == 0 || name == "") {
		document.getElementById('nameChk').innerHTML="";
		nameChk = false;
	}
	else if(! /^[가-힣]{2,6}$/.test(name)) {
		document.getElementById('nameChk').innerHTML="<b><font color=red size=2px>한글 2~6글자 이내로 입력해주세요.</font></b>"
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
		document.getElementById('idChk').innerHTML = "<b><font color=red size=2px>5 - 15자 이내로 입력해주세요.</font></b>"
		idChk = false;
	} else if(!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,15}$/.test(id)){
		document.getElementById('idChk').innerHTML = "<b><font color=red size=2px>영어 소문자, 숫자를 조합하여 입력해주세요.</font></b>"
		idChk = false;
	} else {
		
		//아이디 중복확인
	    idCheckService.getId(id, function(result){
	       if(id == result.id){
	    	   document.getElementById('idChk').innerHTML = "<b><font color=red size=2px>이미 사용중인 아이디입니다.</font></b>";
				idChk = false;	
	       } else{
	    	   document.getElementById('idChk').innerHTML = "<b><font color='green' size=2px>사용가능한 아이디입니다.</font></b>";
				idChk = true;
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
		document.getElementById('pwChk1').innerHTML="<b><font color=red size=2px>8 - 15자 이내로 입력해주세요.</font></b>"
		pwChk1 = false;
	} else if(!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{8,15}$/.test(pw)){
		document.getElementById('pwChk1').innerHTML="<b><font color=red size=2px>영어 소문자, 숫자를 조합하여 입력해주세요.</font></b>"
		pwChk1 = false;
	} else {
		document.getElementById('pwChk1').innerHTML="<b><font color='green' size=2px>사용가능한 비밀번호입니다.</font></b>";
		pwChk1 = true;
	}
}

//비밀번호 확인
function passwordCheck2(){
	var pw = document.getElementById('inputPassword').value;
	var pwChk = document.getElementById('inputPasswordChk').value;
	
	if(pw != pwChk){
		document.getElementById('pwChk2').innerHTML="<b><font color=red size=2px>비밀번호가 일치하지 않습니다.</font></b>"
		pwChk2 = false;
	} else if(pw == pwChk){
		document.getElementById('pwChk2').innerHTML="<b><font color='green' size=2px>비밀번호가 일치합니다.</font></b>"
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
		document.getElementById('phoneChk').innerHTML="<b><font color=red size=2px>하이픈(-) 포함 13자 이내로 입력해주세요.</font></b>"
		phoneChk = false;
	} else {
		
		//핸드폰번호 중복확인
	    phoneCheckService.getPhoneNumber(phoneNumber, function(result){
	       if(phoneNumber == result.phoneNumber){
	    	   document.getElementById('phoneChk').innerHTML = "<b><font color=red size=2px>이미 사용중인 핸드폰번호입니다.</font></b>";
	    	   phoneChk = false;
	       } else{
	    	   document.getElementById('phoneChk').innerHTML = "<b><font color='green' size=2px>사용가능한 핸드폰번호입니다.</font></b>";
	    	   phoneChk = true;
	       }
	    });
	}
}


//확인 후 submit
function confirm() {
	
	var birthChk = document.getElementById("inputBirth").value;
	var addressChk = document.getElementById("inputAddress").value;
	
	if( nameChk==true && idChk==true && pwChk1==true && pwChk2==true && phoneChk==true && birthChk!="" && addressChk!="") {
		document.frm.submit();
	}
	else if((idChk == false)) {
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
<%@ include file="../includes/footer.jsp" %>