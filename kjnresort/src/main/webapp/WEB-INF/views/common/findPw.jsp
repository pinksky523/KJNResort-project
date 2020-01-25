<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="container" style="margin-bottom: 20%; margin-top: 15%;">
<div class="row">
    <div class="col-lg-5 col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    	<form role="form" method="post" action="/common/findPw">
			<fieldset>
				<h3>비밀번호 찾기</h3>
				<hr style="width: 100%; border: solid 2px lightgray;">
				<div class="form-group">
                    <input type="text" name=id id="inputId" class="form-control input-lg" placeholder="아이디" required autofocus>
				</div>
				<div class="form-group">
                    <input type="text" name="name" id="inputName" class="form-control input-lg" placeholder="이름" required>
				</div>
				<div class="form-group">
                    <input type="text" name="phoneNumber" id="inputPhoneNumber" class="form-control input-lg" placeholder="핸드폰번호 (하이픈(-)포함 13자 이내)" required>
				</div>
				<br><hr style="width: 100%">
				
				<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
                        <input type="button" class="btn btn-lg btn-secondary btn-block" onclick="location.href='/common/customLogin'" value="취소">
					</div>
					
					<div class="col-xs-6 col-sm-6 col-md-6">
						<input type="submit" class="btn btn-lg btn-primary btn-block" value="찾기">
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
<%@ include file="../includes/footer.jsp" %>