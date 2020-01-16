<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css"/>
</head>
<body>
	<h1>회원가입</h1>
	<hr>
	<form id="joinForm" method="post">
   <table width="100%" style="padding:5px 0 5px 0; ">
      <tr>
         <th> 이름</th>
         <td><input type="text" class="form-control" id="inputName" style="width: 35%" ></td>
      </tr>
       <tr>
         <th>아이디</th>
         <td class="chkMessage">
        <input type="text" class="form-control" id="inputId"  style="width: 35%" onkeyup="idCheck()"><span id="idChk" class="chkMessage"></span>
         </td>
       </tr>
       <tr>
         <th>비밀번호</th>
         <td><input type="password" class="form-control" id="inputPassword" style="width: 35%"></td>
       </tr>
       <tr>
         <th>비밀번호 확인</th>
         <td><input type="password" class="form-control" id="inputPasswordChk" style="width: 35%"></td>
       </tr>
        <tr>
         <th>핸드폰번호</th>
         <td><input type="text" class="form-control" id="inputPhoneNumber" style="width: 35%"></td>
       </tr>
        <tr>
         <th>생년월일</th>
         <td><input type="date" class="form-control" id="inputBirth" style="width: 35%"></td>
       </tr>
        
        
       <tr>
         <th>성별</th>
           <td class="s">
               <input type="radio" name="chk_mail" checked>남
               <input type="radio" name="chk_mail" value="4">여
            </td>
         </tr>
         
         <tr>
         <tr>
         <th>주소</th>
         <td><input type="text" class="form-control" id="inputAddress"></td>
       </tr>
        
 
           <tr>
             <td colspan="2" align="center">
		   	  <button type="button" class="btn btn-secondary" id="formButton" onclick="history.back()">취소</button>
		      <button type="submit" class="btn btn-primary" id="formButton">가입완료</button>
            </td>
           </tr>
           </table>
          </form>


<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script>
$(function(){
	
	/*  */
});
</script>

</body>
</html>