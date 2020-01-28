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
hr{width:1000px;}
</style>
<%@include file="../includes/adminHeader.jsp"%>
<h2>콘도 관리</h2>
<hr>
<div class="center_div">
	<c:if test="${!empty list }">
		<c:forEach items="${list}" var="condo">
			<div class="roomInfoDiv">
				<c:choose>
					<c:when test="${condo.roomType=='P'}">
						<span>·프라임P</span>
						<img class="condoImg" src="/resources/img/condo/prime.jpg">
					</c:when>
					<c:when test="${condo.roomType=='D'}">
						<span>·디럭스D</span>
						<img class="condoImg" src="/resources/img/condo/deluxe.jpg">
					</c:when>
					<c:when test="${condo.roomType=='N'}">
						<span>·노블N</span>
						<img class="condoImg" src="/resources/img/condo/noble.jpg">
					</c:when>
					<c:when test="${condo.roomType=='R'}">
						<span>·로얄R</span>
						<img class="condoImg" src="/resources/img/condo/royal.jpg">
					</c:when>
				</c:choose>
				<ul class="roomInfoUl">	
					<li><input type="text" name="price" id="${condo.roomType}" value="<fmt:formatNumber value="${condo.price}" groupingUsed="true"></fmt:formatNumber>">원<button data-room="${condo.roomType}" class="modifyBtn">수정</button></li>
					<li>${condo.location }</li>
					<li>${condo.building}</li>
					<li>${condo.accept}명</li>
					<li>${condo.bed}</li>
				</ul>
			</div>
		</c:forEach>
	</c:if>
</div>
<%@include file="../includes/footer.jsp"%>

<script>

$('.modifyBtn').click(function(){
	var roomType=$(this).data('room');
	var price=$(this).siblings('input').val();
	
	if(price.length==0){
		alert('가격을 입력하세요');
		return;
	}
	if(price.length>=7){
		alert('100만원 이상 입력 불가');
		return;
	}
	
	var temp=price.split(',');
	var t1=temp[0];
	var t2=temp[1];
	price=t1+""+t2;
	price=parseInt(price);
	
	if(confirm('가격을 수정하시겠습니까?')){
	$.ajax({
		type:'post',
		url:'/condomanage/modify',
		data:{roomType:roomType,price:price},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(data){
			alert('가격이 수정되었습니다');
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

</script>
