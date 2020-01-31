<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
  
<sec:authorize access="isAnonymous()">
		<%@ include file="../includes/header.jsp" %>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo"/>
	<c:choose>
	
		<c:when test="${pinfo.username eq 'admin'}">
			<%@ include file="../includes/adminHeader.jsp" %>
		</c:when>
		
		<c:otherwise>
			<%@ include file="../includes/header.jsp" %>
		</c:otherwise>
	</c:choose>
</sec:authorize>

<link rel="stylesheet" href="/resources/css/table.css"/>

<style>
h2{text-align: center;}
.table{width:150% !important;text-align:center; } 
body{height:900px !important;}
footer{margin-top:300px !important;}
button{margin-left: 5px; margin-right: 5px;}
</style>

<h2>모집공고 게시판</h2>


	<div class="container" style="height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
                    <thead class="thead-light">
                        <tr>
                            <th>NO.</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty list }">
						<tr>
							<td colspan="6">모집공고가 없습니다.</td>
						</tr>
					</c:if>
                    <c:forEach items="${list}" var="recruit">
                        <tr>
                            <td>${recruit.recruitNo}</td>
                            <td><a href='/recruit/get?recruitNo=${recruit.recruitNo}'>
                            		${recruit.title}
                            	</a>
                            </td>
                            <td><fmt:formatDate value="${recruit.regDate}" pattern="yy-MM-dd"/></td>
                           	<td>${recruit.status}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                <sec:authorize access="hasRole('ROLE_ADMIN')">
	                <button id="regBtn" type="button" class="btn btn-primary pull-right" style="margin-top: 15px;">
	          			글쓰기	
	          		</button> 
                </sec:authorize>
   
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<script>
$(function(){	
	// 글쓰기 버튼을 누르면 게시글 작성 화면으로 이동
	$('#regBtn').on("click",function(){
		self.location = "/recruit/register";
	});
});

</script>
<%@ include file="../includes/footer.jsp" %>