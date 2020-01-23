<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
구매가 완료되었습니다.<br>
상품명 : KJN 리조트 콘도<br>
결제금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${reserve.price}"/> &#8361<br>
예약일시 : <fmt:formatDate value="${reserve.reserveDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate> <br>
<button onclick="location.href=''">예약내역확인</button><button onclick="location.href='/'">메인으로 가기</button>
</body>
