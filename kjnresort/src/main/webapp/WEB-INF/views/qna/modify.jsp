<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
        <!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<style>
h2,p{text-align: center;} 
hr{text-align: center; width:1000px;}
.center_div{text-align: center; width:1000px;  margin:0 auto;}

</style>
<%@include file="../includes/header.jsp"%>
<h2>1:1문의 수정</h2>
<p>고객님의 말씀을 귀기울여 듣는 KJN리조트에 문의하세요
<hr>
<div class="center_div">
<form action="/qna/modify" method="post" id="form">
<select name="type" id="select" style="width:120px; height: 35px;">
							<option value="">카테고리</option>
							<option value="C"
								<c:out value="${qna.category=='C'?'selected':''}"/>>콘도</option>
							<option value="S"
								<c:out value="${qna.category=='S'?'selected':''}"/>>스키</option>
							<option value="E"
								<c:out value="${qna.category=='E'?'selected':''}"/>>기타</option> 
</select>
<input type="hidden" id="qnaNo" name="qnaNo" value="${qna.qnaNo}">
<input name="id" id="id" type="hidden" value="<sec:authentication property="principal.username"/>">
<input id="title" name="title" type="text" maxlength="2000" value="${qna.title }" style="width:625px; height: 35px;"><br>
<textarea id="content" name="content" rows="10" maxlength="2000" style="margin-top:20px; width:750px; height:650px;" >${qna.content }</textarea><br>
<div><br><button class="btn btn-default" id="cancelBtn" style="margin-right:5px;">취소</button><button class="btn btn-warning" id="modiBtn">수정</button></div>
<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
<input type="hidden" id="amount" name="amount" value="${cri.amount}">
<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
<input type="hidden" id="csrf" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
</div>
<%@include file="../includes/footer.jsp"%>
<script>
$('#modiBtn').on("click",function(e){
	 e.preventDefault();
	 var cate=$('#select option:selected').val();
	 var title=$('#title').val();
	 var content=$('#content').val();
	 if(cate==''){
		 alert('카테고리를 입력하세요');
	 }else if(title.length==0){
		 alert('제목을 입력하세요');
	 }else if(content.length==0){
		 alert('내용을 입력하세요');
	 }else{
		 var input="<input type='text' name='category' value='"+cate+"'>";
		 
		 $('#form').append(input).submit();
	 }
});

$('#cancelBtn').on("click",function(e){
	e.preventDefault();
	if(confirm('글 수정을 취소하시겠습니까?')){
	var formObj=$('#form');
	formObj.attr("action","/qna/list");
	formObj.attr("method","get");
	formObj.find("#select").remove();
	formObj.find("#title").remove();
	formObj.find("#content").remove(); 
	formObj.find("#id").remove(); 
	formObj.find("#csrf").remove(); 
	formObj.find("#qnaNo").remove(); 
	formObj.submit();
	}
});


</script>