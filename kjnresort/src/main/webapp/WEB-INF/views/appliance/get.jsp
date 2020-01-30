<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/adminHeader.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<div class="container">
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>지원자 관리</h2>
    </div>
    
<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
                <div class="panel-body">
			    	<div class="form-group">
			    	지원일자 	<fmt:formatDate value="${appliance.regDate }" pattern="yy-MM-dd"/>
			    	</div>
			    	<div class="form-group">
			    	이름		${appliance.name }
			    	</div>
			    	<div class="form-group">
			    	핸드폰 번호	${appliance.phoneNumber }
			    	</div>
			    	<div class="form-group">
			    	주소		${appliance.address }
			    	</div>
			    	<div class="form-group">
			    	이력		${appliance.career }
			    	</div>
			    	<div class="form-group">
			    	자기소개	${appliance.introduction }
			    	</div>
   			 	</div>	<!-- /.panel-body -->
        </div>			
    </div>				<!-- /.col-lg-6 -->
</div>					<!-- /.row -->
    
	<button data-oper='list' class="btn btn-secondary pull-right">목록</button>
	
</div>


<script>
$(function(){

	$("button[data-oper='list']").on("click", function(e){
		self.location="/appliance/list";
	});
	
});
</script>
<%@ include file="../includes/footer.jsp" %>