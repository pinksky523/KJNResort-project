<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용권 구매 결과</title>
</head>
<body>
	<h3> 구매가 완료되었습니다.</h3>
	<div class="form-group">
		<label>상품명 : KJN리조트</label>
	</div>
	
	<div class="form-group">
		<label>구매일자</label>
		<%-- <input class="form-control" name="buyDate" readonly="readonly" value="${ticket.buyDate}"> --%>
	</div>
	
	<div class="form-group">
		<label>결제금액</label>
		<%-- <input class="form-control" name="totalPrice" readonly="readonly" value="${ticket.liftAmount * type.liftPrice} + ${ticket.toolAmount * type.toolPrice}"> --%>
	</div>
	
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>

<script>

</script>
	
</body>
</html>