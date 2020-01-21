<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp" %>
<style>
th {text-align: center;}
</style>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>이용권 관리</h2>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px; text-align: center; width: 100%">
    <hr style="width: 70%">
        <div style="background-color: #EAEAEA; width: 70%; display: inline-block; text-align: center;">
            
            <!-- /.panel-heading -->
            <div class="panel-body" style="display: inline-block;">
            <form role="form" id="modiForm" method="post" action="/ticket/modify">
            <table>
            	<th>이용권</th>
            	<th>가격</th>
            	<th></th>
            	
            	<tr>
            	<td>리프트권</td>
            	<td><input type="text" autofocus placeholder="${tPrice.price}"></td>
                <td> <button id="modBtn" type="submit" class="btn btn-primary pull-right">수정</button></td>
          		</tr>
          		
          		<tr>
          		<td>장비세트</td>
          		<td><input type="text" placeholder="${ttPrice.price}"></td>
          		<td><button onclick="" id="modBtn" type="button" class="btn btn-primary pull-right">수정</button></td>
          		</tr> 
          	</table>
          	</form>
          	<br><br>
            </div>
        </div>
    </div>
</div>          
<script>
$(function(){	

});

</script>
<%@ include file="../includes/footer.jsp" %>