<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<sec:authentication property="principal" var="pinfo"/>
<c:choose>
	<c:when test="${pinfo.username eq 'admin'}">
		<%@ include file="../includes/adminHeader.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="../includes/header.jsp" %>
	</c:otherwise>
</c:choose>
	<h2>회원정보</h2>
	<hr>
	<form role="form" id="joinForm" name="frm" method="post" action="/member/mypageModify">
   <table width="100%" style="padding:5px 0 5px 0; table-layout: fixed; margin-bottom: 170px;">
      
       <tr>
         <th>아이디</th>
         <td><input type="text" name="id" class="form-control" id="inputId" value="${member.id}" readonly></td>
       </tr>
       <tr><td>&nbsp</td></tr>
       <tr>
         <th> 이름</th>
         <td><input type="text" class="form-control" id="inputName" value="${member.name}" readonly></td>
      </tr>
      <tr><td>&nbsp</td></tr>
        <tr>
         <th>핸드폰번호</th>
         <td><input type="text" class="form-control" name="phoneNumber" id="inputPhoneNumber" value="${member.phoneNumber}" readonly></td>
       	 <td class="chkMessage"><span id="phoneChk"></span></td>
       </tr>
       <tr><td>&nbsp</td></tr>
        <tr>
         <th>생년월일</th>
         <td><input type="date" class="form-control" id="inputBirth" value="${member.birth}" readonly></td>
       </tr>	
       <tr><td>&nbsp</td></tr>														
       <tr>
         <th>성별</th>
           <td class="s">
           		<!-- M일경우 '남성' F일경우 '여성' -->
           		<c:if test="${fn:contains(member.gender, 'M')}">
           			<c:set var="gender" value="남성"></c:set>
           		</c:if>
           		<c:if test="${fn:contains(member.gender, 'F')}">
           			<c:set var="gender" value="여성"></c:set>
           		</c:if>
           		
           		<input type="text" class="form-control" value="${gender}" readonly>
            </td>
         </tr>
         <tr><td>&nbsp</td></tr>
         <tr>
         <tr>
         <th>주소</th>
         <td><input type="text" class="form-control" name="address" id="inputAddress" value="${member.address}" style="width: 150%" readonly></td>
       </tr>
       <tr><td>&nbsp</td></tr>
       <tr>
         <th>가입일자</th>
         <td><input type="date" class="form-control" id="inputRegDate" value='<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd"/>' readonly>
       	 <span id="phoneChk"></span></td>
       </tr>
       <tr><td>&nbsp</td></tr>
       <tr>
       <th>상태</th>
       <td class="s">
           		<!-- 1일경우 '일반' 0일경우 '정지' -->
           		<c:if test="${member.status eq 1}">
           			<input type="text" class="form-control" value="일반" style="color: green; font-weight: bold;" readonly>
           			<input type="hidden" name="status" value="1">
           		</c:if>
           		<c:if test="${member.status eq 0}">
           			<input type="text" class="form-control" value="정지" style="color: red; font-weight: bold;" readonly>
           			<input type="hidden" name="status" value="0">
           		</c:if>
           		
           		
            </td>
          </tr>  
            
            <tr><td>&nbsp</td></tr>
           <tr>
             <td colspan="3" align="center">
		   	  <button style="margin: 20px;" type="button" class="btn btn-secondary" id="cancelBtn" data-oper="list">목록</button>
		      <!-- 1일 경우 정지 버튼 생성 /  0일경우 정지해제 버튼 생성 -->
	       		<c:if test="${member.status eq 1}">
	       			<button type="button" data-oper="stop" class="btn btn-danger" id="stopBtn">정지</button>
	       		</c:if>
	       		<c:if test="${member.status eq 0}">
	       			<button style="margin: 20px;" type="button" data-oper="go" class="btn btn-warning" id="goBtn">정지해제</button>
	       		</c:if>
            </td>
           </tr>
           
           </table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          </form>
          <form action="/member/list" id="operForm">
                	<input type="hidden" name="pageNum" value="${cri.pageNum}">
                	<input type="hidden" name="amount" value="${cri.amount}">
                	<!-- 검색 조건과 키워드 파라미터 추가 -->
                	<input type="hidden" name="type" value="${cri.type}">
                	<input type="hidden" name="type" value="${cri.type2}">
                	<input type="hidden" name="keyword" value="${cri.keyword}">
           </form>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/joongBokCheck.js"></script>
<script type="text/javascript" src="/resources/js/mypage.js"></script>
<script>

var pwChk1 = true;
var pwChk2 = true;
var phoneChk = true;


var msg = '<c:out value="${msg}"/>';	

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



$('button').click(function(e) {
	e.preventDefault();
	var oper = $(this).data('oper');
	
	if(oper === 'stop') {
		frm.attr('action', '/member/statusModify');
		memberStop();
	} else if (oper === 'go') {
		frm.attr('action', '/member/statusModify');
		memberGo();
	} 
});

var operForm = $("#operForm");

//버튼 태그의 data-oper 속성에 list가 들어있으면 
$("button[data-oper='list']").on("click", function(e){
	operForm.attr("action", "/member/list")
	operForm.submit();
});

//회원 정지버튼 클릭이벤트
function memberStop() {
	if(confirm("정말 해당회원을 정지시겠습니까?")) {
			document.frm.submit();
	} 
}

//회원 정지해제버튼 클릭이벤트
function memberGo() {
	if(confirm("정말 해당회원을 정지해제시겠습니까?")) {
			document.frm.submit();
	} 
}



//비밀번호 확인
function passwordCheck1(){
	passwordCheck2();
	
	var pw = document.getElementById('inputPassword').value;
	if(pw.length == 0 || pw == "") {
		document.getElementById('pwChk1').innerHTML="";
		pwChk1 = true;
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
	
	if(pwChk.length == 0 || pwChk == "") {
		document.getElementById('pwChk2').innerHTML="";
		pwChk2 = true;
	} else if(pw != pwChk){
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
		document.getElementById('phoneChk').innerHTML="<b><font color=red size=2px>하이픈(-) 포함 13자 이내로 입력해주세요.</font></b>";
		phoneChk = false;
	} else {
		
		//핸드폰번호 중복확인
	    phoneCheckService.getPhoneNumber(phoneNumber, function(result){
	       if(phoneNumber == result.phoneNumber){
	    	   if( phoneNumber == "${member.phoneNumber}") {
	    		   document.getElementById('phoneChk').innerHTML = "";
	    		   phoneChk = true;
	    	   } else {
		    	   document.getElementById('phoneChk').innerHTML = "<b><font color=red size=2px>이미 사용중인 핸드폰번호입니다.</font></b>";
		    	   phoneChk = false;
	    	   }
	       } else{
	    	   document.getElementById('phoneChk').innerHTML = "<b><font color='green' size=2px>사용가능한 핸드폰번호입니다.</font></b>";
	    	   phoneChk = true;
	       }
	    });
	}
}

var frm = $('form');
$('button').click(function(e) {
	e.preventDefault();
	var oper = $(this).data('oper');
	
	if(oper === 'remove') {
		frm.attr('action', '/member/remove');
		deleteMember();
	} else if (oper === 'modify') {
		modify();
	} else if (oper === 'review') {
		frm.attr('action', '/member/myreview');
		
		document.frm.submit();
	}
});



//회원탈퇴버튼 클릭이벤트
function deleteMember() {
	if(confirm("정말 탈퇴하시겠습니까?")) {
			document.frm.submit();
	} 
}


//확인 후 submit
function modify() {
	
	var addressChk = document.getElementById("inputAddress").value;
	
	if( pwChk1==true && pwChk2==true && phoneChk==true && addressChk!="") {
		document.frm.submit();
	} else if(pwChk1 == false) {
		alert('비밀번호를 확인해주세요');
		document.frm.pw1.focus();
	} else if(pwChk2 == false) {
		alert('비밀번호를 확인해주세요');
		document.frm.pw.focus();
	} else if(phoneChk == false) {
		alert('핸드폰번호를 확인해주세요');
		document.frm.phoneNumber.focus();
	} else if(addressChk == null || addressChk == "") {
		alert('주소를 확인해주세요');
		document.frm.address.focus();
	}
}

</script>
<%@ include file="../includes/footer.jsp" %>