<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<%@include file="../includes/header.jsp"%>

<style>
footer{position: relative; top:150px;}
.center_div{align-self: center; margin:0 auto; background:#EAEAEA; width:1000px; height: 600px; padding:50px;}
.center_contents_div{text-align:center; margin:0 auto; margin-top:50px; padding:10px;}
.comple{font-size: 45px; color:#3699DB; }
.info{margin-top:20px; font-size:20px; font-weight: bold; }
button{margin-top:70px; margin-left:10px;}
.info_div{display: block; padding:20px;}
.info_div>span{display:block; margin-top:20px;}
</style>

<div class="center_div">
<div class="center_contents_div">
<span class="comple">구매가 완료되었습니다.</span>
<div class="info_div">
<span class="info">상품명 : KJN 리조트 콘도</span>
<span class="info">결제금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${reserve.price}"/> &#8361</span>
<span class="info">예약일시 : <fmt:formatDate value="${reserve.reserveDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></span>
</div><br>
<button onclick="location.href='/condoreserve/list'" class="btn btn-primary btn-lg">예약내역확인</button><button onclick="location.href='/'" class="btn btn-default btn-lg">메인으로 가기</button>
</div>
</div>
<%@include file="../includes/footer.jsp"%>
