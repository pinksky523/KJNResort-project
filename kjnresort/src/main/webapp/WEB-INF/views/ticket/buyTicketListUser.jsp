<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
    	<br><br><br><br><br><br><br><br><br>
        <h2 class="page-header">나의 이용권 구내내역</h2>
        <hr>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-body">     	   
                 <!-- 검색 조건 및 키워드 입력 부분 -->
                <div class="row">
                	<div class="col-lg-12">
                	</div>
                </div>
                <!-- END 검색 조건 및 키워드 입력 부분 -->	 
                  
                <table class="table table-striped table-bordered table-hover">	   
                    <thead>
                        <tr>
                            <th>#구매번호<!-- Rendering engine --></th>
                            <th>구매일시<!-- Browser --></th>
                            <th>상태<!-- Platform(s) --></th>
                            <th>아이디<!-- Engine version --></th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach items="${list }" var="ticket">
                        <tr class="odd gradeX">
                            <td>${ticket.ticketNo }</td>
                            <td><a class="move" href="/ticket/buyTicketGetUser/${ticket.ticketNo}/${ticket.id}">
                            		${ticket.buyDate}
                            	</a></td>
                            <td>${ticket.status}</td>
                            <td>${ticket.id}</td>
                        </tr>
                    </c:forEach>
                        
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->

<script>
$(function(){

	//result 값을 저장 - 게시글을 등록/수정/삭제한 경우 
	var result = '${result}';
	
	//result 값이 있는지 확인하는 함수 호출
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	//result 값이 있는지 확인하는 함수
	function checkModal(result){
		if(result === '' || history.state )	return;
		
		if(parseInt(result)>0){
			$('.modal-body').html(result + '번 게시글이 등록되었습니다.');	
		}
		
		$('#myModal').modal('show');
	}

});
</script>
<%@ include file="../includes/footer.jsp" %>