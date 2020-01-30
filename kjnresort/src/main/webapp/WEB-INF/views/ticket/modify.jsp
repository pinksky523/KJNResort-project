<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/adminHeader.jsp" %>
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
            <form role="form" method="post" action="/ticket/modify">
            <table class="form-group">
            	<th>이용권</th>
            	<th>가격</th>
            	<th></th>
            	
            	<tr>
            	<td>리프트권</td>
            	<td><input class="form-control" id="textL" name="price" type="text" autofocus placeholder="${tPrice.price}"></td>
                <td> <button id="modBtn" class="btnL" type="submit" class="btn btn-primary pull-right">수정</button></td>
          		</tr>

          	</table>
          	<input class="form-control" type="hidden" name="type" value="lift">
          	<input type="hidden" name="id" value="admin">
         	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          	</form>
          	
          	<form role="form" method="post" action="/ticket/modify">
            <table class="form-group">
          
          		<tr>
          		<td>장비세트</td>
          		<td><input class="form-control" id="textT" name="price" type="text" placeholder="${ttPrice.price}"></td>
          		<td><button id="modBtn" class="btnT" type="submit" class="btn btn-primary pull-right">수정</button></td>
          		</tr> 
          	</table>
          	<input class="form-control" type="hidden" name="type" value="tool">
          	<input type="hidden" name="id" value="admin">
         	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          	</form>
          	
          	<br><br>
            </div>
        </div>
    </div>
</div>          
<script>
$(function(){
	  $(".btnL").on("click", function(e){
		if(document.getElementById('textL').value == '') {
			alert('리프트판매 가격을 입력해주세요');
			e.preventDefault();
		}
	}); 
	 
	  $(".btnT").on("click", function(e){
			if(document.getElementById('textT').value == '') {
				alert('장비판매 가격을 입력해주세요');
				e.preventDefault();
			}
		});  
	
});

</script>
<%@ include file="../includes/footer.jsp" %>