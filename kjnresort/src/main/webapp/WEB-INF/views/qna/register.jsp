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
h1,p{text-align: center;} 
hr{text-align: center; width:1000px;}
.center_div{text-align: center; width:1000px;  margin:0 auto;}

</style>
<body>
<h1>1:1문의 하기</h1>
<p>고객님의 말씀을 귀기울여 듣는 KJN리조트에 문의하세요
<hr>
<div class="center_div">
<form action="/qna/register" method="post" id="form">
<select name="type" id="select" style="width:120px; height: 35px;">
							<option value="">카테고리</option>
							<option value="C"
								<c:out value="C"/>>콘도</option>
							<option value="S"
								<c:out value="S"/>>스키</option>
							<option value="E"
								<c:out value="E"/>>기타</option> 
</select>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<input name="id" type="hidden" value="<sec:authentication property="principal.username"/>">
<input id="title" name="title" type="text" maxlength="2000" placeholder="제목을 입력해주세요" style="width:500px; height: 35px;"><br>
<textarea id="content" name="content" rows="10" maxlength="2000" style="margin-top:20px; width:620px; height:580px;" ></textarea><br>

<button class="btn btn-default" onclick="location.href='/'">취소</button><button class="btn btn-primary" id="regBtn">등록</button>
</form>
</div>
</body>
<script>
$('#regBtn').on("click",function(e){
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
		 var input="<input type='hidden' name='category' value='"+cate+"'>";
		 
		 $('#form').append(input).submit();
	 }
})

</script>
