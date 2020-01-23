<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>공지사항 게시글 등록</h2>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
           <div style="text-align: center;">
                공지사항, 상품안내 등의 소식 등을 모아 고객에게 빠르게 전달해 드립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
				<form method="post" action="/notice/register" name="frm">
		            <div class="form-group">
		                <label>제목: </label>
		                <input class="form-control" name="title" id="inputTitle"></div>
		            <div class="form-group">
		                <label>Top 체크: </label>
		                <input type="checkbox" name="topCheck" value="0"></div>
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
		var contentChk = document.getElementById("inputContent").value;

 				if(titleChk!="" && contentChk!=""){
 					alert("등록이 완료되었습니다.");
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
	//move to list
		formObj.attr("action","/notice/list").attr("method","get");
		formObj.empty();
		formObj.submit();
}

$('input[type="checkbox"]').on('change', function(){
    this.value ^= 1;
});
</script>
 

<%@ include file="../includes/footer.jsp" %>