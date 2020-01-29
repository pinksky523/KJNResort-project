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
.info_div{ align-self: center;  width:1000px; margin:0 auto; margin-top:30px; background: #EAEAEA; padding:40px;}
.reserveInfoUl{list-style: none; }
.reserveInfoUl>li{margin-left:150px; font-size: 26px; margin-bottom:25px;}
.reserveInfoUl>li>span{font-size: 28px; font-weight:bold;  margin-right: 15px;}
.buttons{text-align: right; margin-top:30px;}
footer{margin-top:400px !important;}
</style>
<sec:authentication property="principal" var="pinfo" />
<c:if test="${'admin'!=pinfo.username}">
	 <%@include file="../includes/header.jsp"%>
</c:if>
<c:if test="${'admin'==pinfo.username}">
	 <%@include file="../includes/adminHeader.jsp"%>
</c:if>
	<h2>예약 조회</h2>
	<hr>
	<div class="info_div">
		<ul class="reserveInfoUl">
			<li><span>예약번호</span>${reserve.reserveNo}</li>
			<li><span>예약일시</span>
			<fmt:formatDate value="${reserve.reserveDate}"
					pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></li>
			<li><span>체크인</span>
			<fmt:formatDate value="${reserve.checkIn}" pattern="yyyy-MM-dd(E)"></fmt:formatDate></li>
			<li><span>체크아웃</span>
			<fmt:formatDate value="${reserve.checkOut}" pattern="yyyy-MM-dd(E)"></fmt:formatDate></li>

			<c:choose>
				<c:when test="${0==reserve.status}">
					<li><span>상태<span style="color:#41FF3A; margin-left:8px;">예약</span></li>
				</c:when>
				<c:when test="${1==reserve.status}">
					<li><span>상태</span><span style="color:#2478FF; margin-left:8px;">이용</span></li>
				</c:when>
				<c:when test="${-1==reserve.status}">
					<li><span>상태</span><span style="color:#FF3636; margin-left:8px;">취소</span></li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${'P'==reserve.roomType}">
					<li><span>객실타입</span>프라임P(1층)</li>
				</c:when>
				<c:when test="${'D'==reserve.roomType}">
					<li><span>객실타입</span>디럭스D(2층)</li>
				</c:when>
				<c:when test="${'N'==reserve.roomType}">
					<li><span>객실타입</span>노블N(3층)</li>
				</c:when>
				<c:when test="${'R'==reserve.roomType}">
					<li><span>객실타입</span>로얄R(4층)</li>
				</c:when>
			</c:choose>
			<li><span>객실번호</span>${reserve.roomNo}호</li>
			<li><span>숙박일 수</span>${reserve.nights}일</li>
			<li><span>아이디</span>${reserve.id}</li>
			<li><span>예약자명</span>${reserve.name}</li>
			<li><span>연락처</span>${reserve.phoneNumber}</li>
		</ul>
		<div class="buttons"><sec:authentication property="principal" var="pinfo"/>
			<button id="listBtn" class="btn btn-default btn-lg">목록</button>
			<c:if test="${reserve.status==0}">
					<button id="cancelBtn" class="btn btn-danger btn-lg">예약취소</button>
			</c:if>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${'admin'==pinfo.username}">
					<c:if test="${reserve.status==0}">
						<button id="confirmBtn" class="btn btn-success btn-lg">이용확인</button>
					</c:if>
				</c:if>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${'admin'!=pinfo.username}">
					<c:if test="${reserve.review==0&&reserve.status==1}">
						<button id="reviewBtn" class="btn btn-primary btn-lg">후기등록</button>
					</c:if>
				</c:if>
			</sec:authorize>
		</div>
	</div>
	<form action="/condoreserve/list" id="operForm">
		<input type="hidden" id="pageNum" name="pageNum"
			value="${cri.pageNum}"> <input type="hidden" id="amount"
			name="amount" value="${cri.amount}"> <input type="hidden"
			name="type" value="<c:out value="${cri.type}"/>"> <input
			type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
	</form>
<%@include file="../includes/footer.jsp"%>

<script>
$('#listBtn').on("click",function(){ //목록으로 이동
	$('#operForm').submit();
})

$('#cancelBtn').on("click",function(){ //취소버튼 클릭
	var checkInStr="${reserve.checkIn}";
	console.log(checkInStr);
	var ar=checkInStr.split(" ");
	var month;
	var day;
	var year;
	if(ar[1]=='Feb')
		month=2;
	else if(ar[1]=='Jan')
		month=1;
	else if(ar[1]=='Dec')
		month=12;
	day=parseInt(ar[2]);
	year=parseInt(ar[5]);
	var checkInDate=new Date(year,month-1,day);
	
	var now=new Date();
	now.setHours(0);
	now.setMinutes(0);
	now.setSeconds(0);
	
	var difDay=(checkInDate-now)/(24 * 60 * 60 * 1000);
	if(difDay<=3){
		alert("취소는 4일전 까지만 가능합니다.");
	}
	else{
		if(confirm("예약 취소하시겠습니까?")){
			var reserveNo="${reserve.reserveNo}";
			var id="${reserve.id}";
			console.log(typeof reserveNo);
			console.log(typeof id);
			$.ajax({
				type:'post',
				url:'/condoreserve/cancel',
				data:{reserveNo:reserveNo,id:id},
				beforeSend : function(xhr)
		        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success:function(data){
					alert("예약을 취소하였습니다.");
					window.location.reload();
				},
				error:function(xhr,status,error){
					if(error){
						console.log(status+"/"+error);
					}
				}
			});
		}
	}

});//end click

$('#confirmBtn').on("click",function(){
	if(confirm("이용 확인 하시겠습니까?")){
	var reserveNo="${reserve.reserveNo}";
	var id="${reserve.id}";
	console.log(typeof reserveNo);
	console.log(typeof id);
	$.ajax({
		type:'post',
		url:'/condoreserve/confirm',
		data:{reserveNo:reserveNo,id:id},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(data){
			alert("이용이 확인되었습니다");
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
