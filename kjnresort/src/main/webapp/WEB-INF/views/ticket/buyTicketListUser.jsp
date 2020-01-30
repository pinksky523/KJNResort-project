<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<%@ include file="../includes/header.jsp" %>

<style>
h2{text-align: center; position: relative; bottom: 20px;}
hr{text-align: center; width:1000px; color: gray;}

.container{margin-top:40px; height: 400px; margin-bottom:100px; font-size:2rem;}
.table{width:150% !important;text-align:center; } 
.pagination{justify-content: center; }
.text-center{font-size:2rem;}
thead{background: #E7E7E7;}
.pagination{position: relative; }
footer{margin-top:500px !important;}
.reserve_list{width:1000px;}
</style>

    	<br><br><br><br><br><br><br><br><br>
        <h2>나의 이용권 구매내역</h2>
        <hr>
	    <div class="container">               
         <table class="table table-hover buy_list">	   
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
                     <td>
                     	<c:choose>
							<c:when test="${ticket.status == 0}">
								구매
							</c:when>
							<c:when test="${ticket.status == 1}">
								취소
							</c:when>
							<c:when test="${ticket.status == 2}">
								이용
							</c:when>
						</c:choose>
                     </td>
                     <td>${ticket.id}</td>
                 </tr>
             </c:forEach>
                 
             </tbody>
         </table><!-- END 게시물 출력 테이블 -->
		</div>
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