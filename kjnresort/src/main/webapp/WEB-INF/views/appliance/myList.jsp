<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>지원내역 조회</h2>
    </div>
</div>
<div class="row">
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
                            <th>이름</th>
                            <th>핸드폰 번호</th>
                            <th>지원상태</th>
                            <th>제출일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="member">
                        <tr>
                            <td>${member.name}</td>
                            <td>${member.phoneNumber}</td>
                            <td>${appliance.status}</</td>
                           	<td>${appliance.regDate}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                <button id="regBtn" type="button" class="btn btn-primary pull-right">
          			지원서 작성	
          		</button> 
   
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
		self.location = "/appliance/register";
	});
});
</script>

<%@ include file="../includes/footer.jsp" %>