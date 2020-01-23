<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/table.css"/>
<style>
h1{text-align: center;}
hr{text-align: center; width:1000px;}
.battle_board{width:100%; }
.container{margin-top:100px; height: 400px; margin-bottom:300px; font-size:2rem;}
.table{width:150% !important;text-align:center; } 
.pagination{justify-content: center; margin-bottom:200px;}
.text-center{font-size:2rem;}
thead{background: #E7E7E7;}
</style>
<body>
<h1>콘도 예약 내역</h1>
<hr>

				<div class="container">
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
										<td>${rvo.reserveNo}</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					
				</div>
				
				<!-- 페이징 -->
				 <form id="actionForm">
  		<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cri.pageNum}">
  		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
  		<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>">
  		<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
  	</form>
  <nav>
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
</nav>
		
		
</body>
