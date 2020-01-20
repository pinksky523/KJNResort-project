<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

 <div class="row">
     <div class="col-lg-12">
         <h1 class="page-header">모집공고 게시판 관리</h1>
     </div>
 </div>
 
<div class="row">
     <div class="col-lg-12">
         <div class="panel panel-default">
             <div class="panel-heading">
             	게시글 수정
             </div> <!-- /.panel-heading -->
             <div class="panel-body">
  				<form method="post" action="/recruit/modify" name="frm">
	             	<div class="form-group">
		                <label>제목: </label>
		                <input class="form-control" name="title" id="inputTitle" value="${recruit.title }"></div>
		            <div class="form-group">
		                <label>글 번호: </label>
		                <input class="form-control" name="recruitNo" value="${recruit.recruitNo }" readonly></div>
		            <div class="form-group">
		                <label>상태: </label>
		                <input class="form-control" name="status" id="inputStatus" value="${recruit.status }" ></div>
		            <div class="form-group">
		                <label>접수마감: </label>
		                <input type="date" class="form-control" name="deadLine" id="inputDeadLine" value="${recruit.deadLine}" ></div>
		            <div class="form-group">
	                    <label>내용: </label>
	                    <textarea class="form-control" rows="8" name="content" id="inputContent">${recruit.content }</textarea></div>
	                    <input type="hidden" name="id" value="admin">
	                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="button" onclick="modify()" class="btn btn-warning pull-right">수정</button>
                    <button type="button" onclick="list()" class="btn btn-secondary pull-right">취소</button>
				</form>
             </div>	<!-- /.panel-body -->
         </div> 	<!-- /.panel -->
     </div> 		<!-- /.col-lg-6 -->
</div> 				<!-- /.row -->

<script>
function modify() {
	
		var titleChk = document.getElementById("inputTitle").value;
		var statusChk = document.getElementById("inputStatus").value;
		var deadLineChk = document.getElementById("inputDeadLine").value;
		var contentChk = document.getElementById("inputContent").value;

 				if(titleChk!="" && statusChk!="" && deadLineChk!="" && contentChk!=""){
 					alert("수정이 완료되었습니다.");
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