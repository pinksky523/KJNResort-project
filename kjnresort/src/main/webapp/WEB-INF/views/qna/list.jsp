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
<link rel="stylesheet" href="/resources/css/table.css"/>
<style>
h2{text-align: center;}
hr{text-align: center; width:1000px;}

.container{height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;}
.table{width:150% !important;text-align:center; } 
.pagination{justify-content: center; }
.text-center{font-size:2rem;}
thead{background: #E7E7E7;}
.pagination{position: relative; bottom:30px;}
body{height:900px !important;}
.qnatable{width:400px;}
</style>
<sec:authentication property="principal" var="pinfo" />
<c:if test="${'admin'!=pinfo.username}">
	 <%@include file="../includes/header.jsp"%>
</c:if>
<c:if test="${'admin'==pinfo.username}">
	 <%@include file="../includes/adminHeader.jsp"%>
</c:if>
<h2>1:1문의</h2>
<hr>

	<div class="container">
		
		<div style="text-align: right">
			<sec:authentication property="principal" var="pinfo" />
			<sec:authorize access="isAuthenticated()">
				<c:if test="${'admin'==pinfo.username}">
					<form action="/qna/list">
						<select name="type" id="select">
							<option value="CSE">카테고리전체</option>
							<option value="C"
								<c:out value="${pageMaker.cri.type=='C'?'selected':''}"/>>콘도</option>
							<option value="S"
								<c:out value="${pageMaker.cri.type=='S'?'selected':''}"/>>스키</option>
							<option value="E"
								<c:out value="${pageMaker.cri.type=='S'?'selected':''}"/>>기타</option>	
						</select>
						<select name="keyword" id="keyword">
							<option value="">답변여부</option>
							<option value="Y"
								<c:out value="${pageMaker.cri.keyword=='Y'?'selected':''}"/>>답변</option>
							<option value="N"
								<c:out value="${pageMaker.cri.keyword=='N'?'selected':''}"/>>미답변</option>
						</select>
						<button id="searchBtn" style="display: inline;"
							"class="btn btn-default">검색</button>
					</form>

				</c:if>
			</sec:authorize>


		</div>
		<table class="table table-hover qnatable">
			<thead>
				<tr>
					<th>문의번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>답변여부</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr>
						<td colspan="6">문의 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty list }">
					<c:forEach items="${list}" var="qvo">
						<tr>
							<td>${qvo.qnaNo}</td>
							<c:choose>
								<c:when test="${qvo.category=='C'}">
									<td>콘도</td>
								</c:when>
								<c:when test="${qvo.category=='S'}">
									<td>스키</td>
								</c:when>
								<c:when test="${qvo.category=='E'}">
									<td>기타</td>
								</c:when>
							</c:choose>
							<td><a class="move" href="${qvo.qnaNo}">${qvo.title}</a></td>
							<td>${qvo.id}</td>
							<td><fmt:formatDate value="${qvo.regDate}"
									pattern="yyyy-MM-dd"></fmt:formatDate></td>
							<td>${qvo.isAnswered }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>

	<!-- 페이징 -->
				 <form id="actionForm" action="/qna/list">
  		<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cri.pageNum}">
  		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
  		<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>">
  		<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
  	</form>
  <nav>
  
   <div style="text-align: center;">
  <ul class="pagination">
  <c:if test="${pageMaker.prev}">
    <li class="paginate_button previous">
    	
      <a href="${pageMaker.startPage-1}" aria-label="Previous">
        <span aria-hidden="true">Previous</span>
      </a>
    </li>
    </c:if>
    
    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
    	 <li class="paginate_button ${pageMaker.cri.pageNum==num ? "active":"" } ">
    	 	<a href="${num}">${num}</a>
    	 </li>
    </c:forEach>
    
    <c:if test="${pageMaker.next}">
    <li class="paginate_button next">
      <a href="${pageMaker.endPage+1}" aria-label="Next">
        <span aria-hidden="true">Next</span>
      </a>
    </li>
    </c:if>
  </ul>
  </div>
</nav>
		
<%@include file="../includes/footer.jsp"%>

<script>

var actionForm=$("#actionForm");
$(".move").on("click",function(e){
	 e.preventDefault();
	 actionForm.append("<input type='hidden' name='qno' value='"+$(this).attr("href")+"'>");
	 actionForm.attr("action","/qna/get");
	 actionForm.submit();
});
$(".paginate_button previous").on("click",function(e){
		 e.preventDefault();
		 $('#pageNum').val($(this).attr('href'));
		 actionForm.submit();
});

$(".paginate_button next").on("click",function(e){
	 	e.preventDefault();
		 $('#pageNum').val($(this).attr('href'));
		 actionForm.submit();
});
$(".paginate_button a").on("click",function(e){
		 e.preventDefault();
	 	console.log('click');
	 	//actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	 	$('#pageNum').val($(this).attr('href'));
	 actionForm.submit();
});


$(function(){
	var result='${result}';
	
	if(result===''||history.state){
			return;
		}
	
	if(result=='modiSuccess'){
		alert("수정이 완료되었습니다.");
	}
	if(result=='regiSuccess'){
		alert("글이 등록되었습니다.");
	}
	if(result=='delSuccess'){
		alert("글이 삭제되었습니다.");
	}
	
});
</script>