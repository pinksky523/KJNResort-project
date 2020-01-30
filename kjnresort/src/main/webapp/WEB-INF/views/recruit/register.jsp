<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/adminHeader.jsp" %>

<style>
h2{text-align: center;}
body{height:900px !important;}
footer{margin-top:300px !important;}
button{margin-left: 5px; margin-right: 5px;}
</style>

<h2>모집공고 게시글 등록</h2>


	<div class="container" style="height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
           <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
				<form method="post" action="/recruit/register" name="frm">
		            <div class="form-group">
		                <label>제목: </label>
		                <input class="form-control" name="title" id="inputTitle"></div>
		            <div class="form-group">
		                <label>상태: </label>
		                <input class="form-control" name="status" id="inputStatus"></div>
		            <div class="form-group">
		                <label>접수마감: </label>
		                <input type="date" class="form-control" name="deadLine" id="inputDeadLine"></div>
		            <div class="form-group">
	                    <label>내용: </label>
	                    <textarea class="form-control" rows="8" name="content" id="inputContent"></textarea></div>
	                    <input type="hidden" name="id" value="admin">
	                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                <button type="button" onclick="register()" class="btn btn-primary pull-right">등록</button>
	                <button type="button" onclick="list()" class="btn btn-secondary pull-right">취소</button>
				</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<script>
function register() {
	
		var titleChk = document.getElementById("inputTitle").value;
		var statusChk = document.getElementById("inputStatus").value;
		var deadLineChk = document.getElementById("inputDeadLine").value;
		var contentChk = document.getElementById("inputContent").value;

 				if(titleChk!="" && statusChk!="" && deadLineChk!="" && contentChk!=""){
 					alert("등록이 완료되었습니다.");
 					document.frm.submit();
 				} else if(titleChk == null || titleChk === ""){
					alert('제목을 입력해주세요');
					document.frm.title.focus();
				} else if(statusChk == null || statusChk === ""){
					alert('모집상태를 입력해주세요');
					document.frm.status.focus();
				} else if(deadLineChk == null || deadLineChk === ""){
					alert('마감일자를 입력해주세요');
					document.frm.deadLine.focus();
				} else if(contentChk == null || contentChk === ""){
					alert('내용을 입력해주세요');
					document.frm.content.focus();
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