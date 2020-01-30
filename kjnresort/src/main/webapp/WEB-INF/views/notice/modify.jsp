<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/adminHeader.jsp" %>

<style>
h2{text-align: center;}
body{height:900px !important;}
footer{margin-top:300px !important;}
button{margin-left: 5px; margin-right: 5px;}
</style>

<h2>공지사항 게시글 수정</h2>

 
	<div class="container" style="height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                공지사항, 상품안내 등의 소식 등을 모아 고객에게 빠르게 전달해 드립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
 			<div class="panel-body">
				<form method="post" action="/notice/modify" name="frm">
		            <div class="form-group">
		                <label>제목: </label>
		                <input class="form-control" name="title" id="inputTitle" value="${notice.title }"></div>
		            <div class="form-group">
		                <label>Top 체크: </label>
		                <input type="checkbox" name="topCheck" id="topCheck" value="${notice.topCheck }" ></div>
		            <div class="form-group">
	                    <label>내용: </label>
	                    <textarea class="form-control" rows="8" name="content" id="inputContent">${notice.content }</textarea></div>
	                    <input type="hidden" name="noticeNo" value="${notice.noticeNo }">
	                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                <button type="button" onclick="modify()" class="btn btn-warning pull-right">수정</button>
	                <button type="button" onclick="list()" class="btn btn-secondary pull-right">취소</button>
				</form>
             </div>	<!-- /.panel-body -->
         </div> 	<!-- /.panel -->
     </div> 		<!-- /.col-lg-6 -->
</div> 				<!-- /.row -->

<script>
$(function(){
	var topChk	= document.getElementById("topCheck").value;
	
		if(topChk == 1){
			document.getElementById("topCheck").checked = true;
		} else if(topChk == 0){
			document.getElementById("topCheck").checked = false;
		}
	
		$("#topCheck").change(function(){
		if($("#topCheck").is(":checked")){
			document.getElementById("topCheck").value = 1;
		} else {
			document.getElementById("topCheck").value = 0;
		}
	});
});
	
function modify() {
		
		var titleChk = document.getElementById("inputTitle").value;
		var contentChk = document.getElementById("inputContent").value;
		var topChk	= document.getElementById("topCheck").value;

			if(titleChk!="" && contentChk!=""){
				alert(topChk);
				alert("수정이 완료되었습니다.");
				document.frm.submit();
			} else if(titleChk == null || titleChk === ""){
				alert('제목을 입력해주세요');
				document.frm.title.focus();
			} else if(contentChk == null || contentChk === ""){
				alert('내용을 입력해주세요');
				document.frm.content.focus();
			}
};

function list(){
	var formObj = $("form");
	//	게시글 목록으로 이동
		formObj.attr("action","/notice/list").attr("method","get");
		formObj.empty();
		formObj.submit();
}

</script>


<%@ include file="../includes/footer.jsp" %>