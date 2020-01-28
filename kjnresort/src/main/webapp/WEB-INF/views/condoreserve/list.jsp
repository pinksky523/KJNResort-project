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
h1{text-align: center;}
hr{text-align: center; width:1000px;}

.container{margin-top:100px; height: 400px; margin-bottom:200px; font-size:2rem;}
.table{width:150% !important;text-align:center; } 
.pagination{justify-content: center; }
.text-center{font-size:2rem;}
thead{background: #E7E7E7;}
.pagination{position: relative; bottom: 50px;}
</style>
<body>
<h1>콘도 예약 내역</h1>
<hr>

	<div class="container">
		<div style="text-align: right">
			<sec:authentication property="principal" var="pinfo" />
			<sec:authorize access="isAuthenticated()">
				<c:if test="${'admin'==pinfo.username}">
					<form action="/condoreserve/list">
						<select name="type" id="select">
							<option value="IP">조건 전체</option>
							<option value="I"
								<c:out value="${pageMaker.cri.type=='I'?'selected':''}"/>>아이디</option>
							<option value="P"
								<c:out value="${pageMaker.cri.type=='P'?'selected':''}"/>>핸드폰번호(-포함)</option>
						</select> <input name="keyword" id="keyword"
							style="display: inline; width: 30%;" type="text"
							class="form-control" placeholder="Text input"
							value="${pageMaker.cri.keyword}">
						<button id="searchBtn" style="display: inline;"
							"class="btn btn-default">검색</button>
					</form>

				</c:if>
			</sec:authorize>



		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>예약번호</th>
					<th>예약일시</th>
					<th>상태</th>
					<th>아이디</th>
					<th>핸드폰번호</th>
					<th>체크인</th>
					<th>체크아웃</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr>
						<td colspan="7">예약 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty list }">
					<c:forEach items="${list}" var="rvo">
						<tr>
							<td><a class="move" href="${rvo.reserveNo}">${rvo.reserveNo}</a></td>
							<td><fmt:formatDate value="${rvo.reserveDate}"
									pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<c:choose>
								<c:when test="${0==rvo.status}">
									<td>예약</td>
								</c:when>
								<c:when test="${1==rvo.status}">
									<td>이용</td>
								</c:when>
								<c:when test="${-1==rvo.status}">
									<td>취소</td>
								</c:when>
							</c:choose>
							<td>${rvo.id}</td>
							<td>${rvo.phoneNumber}</td>
							<td><fmt:formatDate value="${rvo.checkIn}"
									pattern="yyyy-MM-dd(E)"></fmt:formatDate></td>
							<td><fmt:formatDate value="${rvo.checkOut}"
									pattern="yyyy-MM-dd(E)"></fmt:formatDate></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>

	<!-- 페이징 -->
				 <form id="actionForm" action="/condoreserve/list">
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
		
		
</body>
<script>

var actionForm=$("#actionForm");
$(".move").on("click",function(e){
	 e.preventDefault();
	 actionForm.append("<input type='hidden' name='rno' value='"+$(this).attr("href")+"'>");
	 actionForm.attr("action","/condoreserve/get");
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
</script>
