<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/adminHeader.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>

<style>
h2{text-align: center;}
body{height:900px !important;}
footer{margin-top:300px !important;}
button{margin-left: 5px; margin-right: 5px;}
.a{font-size: 25px; font-weight:bold;  margin-right: 15px;}
.b{position: absolute; left: 220px;}
</style>

<h2>지원자 관리</h2>

	<div class="container" style="height: 400px; margin-bottom:200px; font-size:2rem; width:1000px !important;">
    <div class="col-lg-12" style="padding-bottom: 20px;">
        <div>
            <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
                <div class="panel-body" style=" background: #EAEAEA;">
			    	<div class="form-group">
			    		<span class="a">지원일자</span>
			    		<span class="b"><fmt:formatDate value="${appliance.regDate }" pattern="yy-MM-dd"/></span>
			    	</div>
			    	<div class="form-group">
			    		<span class="a">이름</span>
			    		<span class="b">${appliance.name }</span>
			    	</div>
			    	<div class="form-group">
			    		<span class="a">핸드폰 번호</span>
			    		<span class="b">${appliance.phoneNumber }</span>
			    	</div>
			    	<div class="form-group">
			    		<span class="a">주소</span>
			    		<span class="b">${appliance.address }</span>
			    	</div>
			    	<div class="form-group">
			    		<div class="a" style="display: inline-block;">이력</div>
			    		<div class="b" style="display: inline-block; padding-right: 25px;">${appliance.career }</div>
			    	</div>
			    	<div class="form-group">
			    		<div class="a" style="display: inline-block;">자기소개</div>
			    		<div class="b" style="display: inline-block; padding-right: 25px;">${appliance.introduction }</div>
			    	</div>
   			 	</div>	<!-- /.panel-body -->
        </div>	
        		<button data-oper='list' class="btn btn-secondary pull-right" style="margin-top: 10px;">목록</button>		
    </div>				<!-- /.col-lg-6 -->
</div>					<!-- /.row -->
 


<script>
$(function(){

	$("button[data-oper='list']").on("click", function(e){
		self.location="/appliance/list";
	});
	
});
</script>
<%@ include file="../includes/footer.jsp" %>