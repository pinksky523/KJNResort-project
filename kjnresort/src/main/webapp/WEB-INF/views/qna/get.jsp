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
h2{text-align: center;}
hr{text-align: center; width:1000px;}
.center_div{ width:1000px; margin:0 auto;}
.cate{font-size: 30px; font-weight: bold;}
.title_div{background: #BDBDBD; width:1000px; font-size:25px;}
.writer,.regDate,.isans{font-size:20px;}
.regDate,.isans{margin-left:120px;}
.qna_content>p{color:black;  margin-top:10px; border-top: 1px solid; border-top-color:gray; border-bottom: 1px solid; border-bottom-color:gray;}
.user_buttons{text-align: right; margin-top:5px;}
.qna_info{margin-top:10px;}
footer{position:relative; top:100px;}
.ansArea{width:1000px; margin-top:7px;}
.showAnaswer{margin-top:10px; border-top: 1px solid; border-top-color:gray; border-bottom: 1px solid; border-bottom-color:gray; }
.showAnaswer>p{color:black;}
</style>
<sec:authentication property="principal" var="pinfo" />
<c:if test="${'admin'!=pinfo.username}">
	 <%@include file="../includes/header.jsp"%>
</c:if>
<c:if test="${'admin'==pinfo.username}">
	 <%@include file="../includes/adminHeader.jsp"%>
</c:if>
<h2>1:1문의 조회</h2>
<hr>
<div class="center_div">
<div class="title_div">
			<c:choose>
				<c:when test="${qna.category=='C'}">
					<span class="cate"> [콘도] </span>
				</c:when>
				<c:when test="${qna.category=='S'}">
					<span class="cate"> [스키] </span>
				</c:when>
				<c:when test="${qna.category=='E'}">
					<span class="cate"> [기타] </span>
				</c:when>
			</c:choose>
			<span class="title">${qna.title }</span>
</div>
<div class="qna_info">
<span class="writer">작성자 | ${qna.id}</span><span class="regDate">작성일 | <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"></fmt:formatDate></span><span class="isans">답변 여부 | ${qna.isAnswered}</span>
</div>
<div class="qna_content">
<p>${qna.content }</p>
</div>
<div class="user_buttons"><button id="list" class="btn btn-default">목록</button>
<sec:authentication property="principal" var="pinfo" />
	<sec:authorize access="isAuthenticated()">
		<c:if test="${'admin'!=pinfo.username}">
			<button id="modifyBtn" class="btn btn-warning">수정</button> <button id="delBtn" class="btn btn-danger">삭제</button>
		</c:if>
	</sec:authorize></div>
			
				<sec:authorize access="isAuthenticated()">
					<c:if test="${qna.isAnswered=='Y' }">
							<span style="color:gray; font-size:15px;">답변</span>
					 		<div class="showAnaswer">
					 			<p>${qna.answer}</p>
					 		</div>
					 			<span style="margin-top:5px;">답변일<fmt:formatDate value="${qna.answerRegDate}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
					 			<c:if test="${'admin'==pinfo.username}"><div style="float: right; margin-top:10px;"><button id="delAnsBtn" class="btn btn-danger">삭제</button></div></c:if>
					 		
					</c:if>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${qna.isAnswered=='N' }">
						<c:if test="${'admin'==pinfo.username}">
							<span style="color:gray; font-size:15px;">답변등록</span>
							<textarea rows="10" maxlength="2000" id="answer" name="answer" class="ansArea"></textarea>
							<button id="answerBtn" class="btn btn-primary" style="margin-top:10px; float: right;">등록</button>
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
<%@include file="../includes/footer.jsp"%>

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
	$('#operForm').find('#csrf').remove();
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