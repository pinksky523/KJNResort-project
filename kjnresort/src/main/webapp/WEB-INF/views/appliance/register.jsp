<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>지원서 작성</h2>
    </div>
</div>
<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
           <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
            	<form method="post" action="/appliance/register" name="frm"> 
					<div class="form-group">
		                <label>이름 : </label>
		                <input class="form-control" name="name"
		                value="${member.name }" readonly></div>
		            <div class="form-group">
		                <label>핸드폰 번호 : </label>
		                <input class="form-control" name="phoneNumber"
		                value="${member.phoneNumber }" readonly></div>
		            <div class="form-group">
		                <label>주소 : </label>
		                <input class="form-control" name="address"
		                value="${member.address }" readonly></div>
		            <div class="form-group">
		                <label>이력 : </label>
		               <textarea class="form-control" rows="3" name="career" id="inputCareer"></textarea></div>
		            <div class="form-group">
	                    <label>자기소개 : </label>
	                    <textarea class="form-control" rows="10" name="introduction" id="inputIntro"></textarea></div>
	                	<input type="hidden" name="id" value="${member.id }">
	                	<input type="hidden" name="recruitNo" value="${recruit.recruitNo }">    
	                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                <button type="button" onclick="register()" class="btn btn-primary pull-right">지원하기</button>
	                <button type="button" onclick="save()" class="btn btn-success pull-right">임시저장</button>
	                <button type="button" onclick="list()" class="btn btn-secondary pull-right">취소</button>
				</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<script>
function register() {
	
		var careerChk = document.getElementById("inputCareer").value;
		var introChk = document.getElementById("inputIntro").value;

 				if(careerChk!="" && introChk!=""){
 					alert("지원서가 제출되었습니다.");
 					document.frm.submit();
 				} else if(careerChk == null || careerChk === ""){
					alert('이력을 입력해주세요');
					document.frm.title.focus();
				} else if(introChk == null || introChk === ""){
					alert('자기소개를 입력해주세요');
					document.frm.status.focus();
				} 
};

function list(){
	var formObj = $("form");
	//move to list
		formObj.attr("action","/recruit/list").attr("method","get");
		formObj.empty();
		formObj.submit();
}
</script>


<%@ include file="../includes/footer.jsp" %>