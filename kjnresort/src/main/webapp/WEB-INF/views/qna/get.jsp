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
h1{text-align: center;}
hr{text-align: center; width:1000px;}
.center_div{background: red; width:1000px; margin:0 auto;}
</style>
<body>
<h1>1:1문의 조회</h1>
<hr>
<div class="center_div">
<span>문의번호</span><span>${qna.qnaNo}</span>
<span>카테고리</span><c:choose>
				<c:when test="${qna.category=='C'}">
					<span>콘도</span>
				</c:when>
				<c:when test="${qna.category=='S'}">
						<span>스키</span>
				</c:when>
				<c:when test="${qna.category=='E'}">
						<span>기타</span>
				</c:when>
			</c:choose>
<span>작성일</span><span><fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
<p>${qna.title }</p>
<span>${qna.content }</span>

<sec:authentication property="principal" var="pinfo" />
	<sec:authorize access="isAuthenticated()">
		<c:if test="${'admin'!=pinfo.username}">
			<button id="modifyBtn">수정</button><button id="delBtn">삭제</button>
		</c:if>
	</sec:authorize><button id="list">목록</button>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${'admin'==pinfo.username}">
					<c:if test="${qna.isAnswered=='Y' }">
						<span>답변</span>
					 		<p>${qna.answer}</p>
					 		<span>답변일</span><span><fmt:formatDate value="${qna.answerRegDate}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
					 		<button id="delAnsBtn">삭제</button>
					</c:if>
					
					<c:if test="${qna.isAnswered=='N' }">
							<textarea rows="10" maxlength="2000" id="answer" name="answer"></textarea>
							<button id="answerBtn">등록</button>
					</c:if>
				</c:if>
			</sec:authorize>
			<form action="/qna/modify" id="operForm">
				<input type="hidden" id="qno" name="qno" value="${qna.qnaNo}">
				<input type="hidden" id="id" name="id" value="<sec:authentication property="principal.username"/>">
			<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}"> 
			<input type="hidden" id="amount" name="amount" value="${cri.amount}"> 
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"> 
			<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
			<input type="hidden" id="csrf" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
</div>
</body> 

<script>
$('#delAnsBtn').on("click",function(){
	if(confirm('답변을 삭제하시겠습니까?')){
		var login_Id=null;
		<sec:authorize access="isAuthenticated()">
			login_Id='<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var qno="${qna.qnaNo}";
		
		$.ajax({
			type:'post',
			url:'/qna/deleteAnswer',
			data:{qno:qno,id:login_Id},
			beforeSend : function(xhr)
	        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success:function(data){
				alert("답변이 삭제되었습니다");
				window.location.reload();
			},
			error:function(xhr,status,error){
				if(error){
					console.log(status+"/"+error);
				}
			}
		});
	}
});



$('#answerBtn').on("click",function(){
	var answer=$('#answer').val();
	if(answer.length==0){
		alert('답변을 입력하세요.');
		return;
	}else{
	
		if(confirm('답변을 등록하시겠습니까?')){
			var login_Id=null;
			<sec:authorize access="isAuthenticated()">
				login_Id='<sec:authentication property="principal.username"/>';
			</sec:authorize>
			
			var qno="${qna.qnaNo}";
			
			$.ajax({
				type:'post',
				url:'/qna/registerAnswer',
				data:{qno:qno,answer:answer,id:login_Id},
				beforeSend : function(xhr)
		        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success:function(data){
					alert("답변이 등록되었습니다.");
					window.location.reload();
				},
				error:function(xhr,status,error){
					if(error){
						console.log(status+"/"+error);
					}
				}
			});
		}
	}
});

$('#delBtn').on("click",function(){
	if(confirm('글을 삭제하시겠습니까?')){
	var formObj=$('#operForm');
	formObj.attr("method","post");
	formObj.attr("action","/qna/remove");
	formObj.submit();
	}
});


$('#modifyBtn').on("click",function(){
	
	$('#operForm').find('#id').remove();
	$('#operForm').submit();
	
});

$('#list').on("click",function(){
	var formObj=$('#operForm');
	formObj.attr("action","/qna/list");
	formObj.find("#qno").remove(); 
	formObj.find("#id").remove(); 
	formObj.find("#csrf").remove(); 
	formObj.submit();
});
</script>