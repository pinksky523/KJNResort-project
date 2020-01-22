<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>내가 쓴 후기</h2>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
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
	                <button id="regBtn" type="button" class="btn btn-primary pull-right">
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

</script>
<%@ include file="../includes/footer.jsp" %>