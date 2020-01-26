<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<h2>이벤트</h2>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                4계절을 골고루 즐기는 행복과 웃음으로 가득한 KJN리조트 이벤트입니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table border="" style="width: 100%;">
					<tbody>
					<tr style="width: 100%;">
						<td style="width: 33%;">1번 데이타 셀</td>
						<td style="width: 33%;">2번 데이타 셀</td>
						<td style="width: 33%;">3번 데이타 셀</td>
					</tr>
					<tr>
						<td style="width: 33%;">4번 데이타 셀</td>
						<td style="width: 33%;">5번 데이타 셀</td>
						<td style="width: 33%;">6번 데이타 셀</td>
					</tr>
					<tr>
						<td style="width: 33%;">7번 데이타 셀</td>
						<td style="width: 33%;">8번 데이타 셀</td>
						<td style="width: 33%;">9번 데이타 셀</td>
					</tr>
					</tbody>
					</table>
                
                
                
                <sec:authorize access="hasRole('ROLE_ADMIN')">
	                <button id="regBtn" type="button" class="btn btn-primary pull-right">
	          			이벤트 등록	
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
		self.location = "/event/register";
	});
});

</script>
<%@ include file="../includes/footer.jsp" %>