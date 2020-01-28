<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

        <h2>이벤트 등록</h2>
<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
           <div style="text-align: center;">
               4계절을 골고루 즐기는 행복과 웃음으로 가득한 KJN리조트 이벤트입니다.
            </div>
            <hr style="width: 100% !important;">
            <!-- /.panel-heading -->
            <div class="panel-body">
		
   		<table style="padding:5px 0 5px 0; table-layout: fixed; width: 100%;">
      
       <tr>
         <th>제목</th>
         <td style="width: 33%"><input type="text" name="title" class="form-control" id="inputTitle" value="${event.title}" readonly></td>
         <td></td>
       </tr>
       <tr><td>&nbsp</td></tr>
        <tr>
         <th>기간</th>
         <td>
         <div style="display: inline;">
         <input type="text" class="form-control" name="eventStart" id="inputEventStart" value="${event.eventStart}" readonly>
        ~
         <input type="text" class="form-control" name="eventEnd" id="inputEventEnd" value="${event.eventEnd}" readonly>
         </div>
         </td>
       </tr>
       <tr><td>&nbsp</td></tr>
      												
           
           </table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<!-- 첨부파일 -->
<!-- 파일 첨부하는 순간 업로드 할 수 있게 (따로 업로드 버튼 없음) -->
	                  <div id="thumbResult" class="uploadResult" style="height: 300px; text-align: center;">
	                      <ul style="list-style: none;">
	                      </ul>
	                  </div>

	                  <div id="detailResult" class="uploadResult" style="height: 300px; text-align: center;">
	                      <ul style="list-style: none;">
	                      </ul>
	                  </div>



<div style="text-align: center;">
	<button type="button" class="btn btn-secondary" id="eventList" onclick="location.href='/event/list'">목록</button>
	
	 <!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->
	            <sec:authentication property="principal" var="pinfo"/>
	            <sec:authorize access="isAuthenticated()">	<!-- 로그인을 했나? -->
	            <c:if test="${pinfo.username eq event.id}">	<!-- 내가 작성한 글인가?  -->
	            	<button data-oper='modify' class="btn btn-warning" id="eventModify">수정</button>
	            </c:if>
	            </sec:authorize>
	            
	            <sec:authentication property="principal" var="pinfo"/>
	            <sec:authorize access="isAuthenticated()">	<!-- 로그인을 했나? -->
	            <c:if test="${pinfo.username eq event.id}">	<!-- 내가 작성한 글인가?  -->
	            	<button data-oper='delete' class="btn btn-danger" id="eventDelete">삭제</button>
	            </c:if>
	            </sec:authorize>
	            
	            
	            
	            <sec:authorize access="isAuthenticated()">	<!-- 로그인을 했나? -->
	            <c:if test="${pinfo.username ne 'admin'}">	<!-- 내가 작성한 글인가?  -->
	            	<button data-oper='apply' class="btn btn-success" id="eventApply">응모하기</button>
	            </c:if>
	            </sec:authorize>
	   			                   
</div>		      
<form action="/event/modify" id="operForm">
	<input type="hidden" id="eventNo" name="eventNo" value="${event.eventNo}">
	<input type="hidden" name="pageNum" value="${cri.pageNum}">
	<input type="hidden" name="amount" value="${cri.amount}">
</form> 
<script>
$(function(e){
	//게시물 하나에 대한 첨부파일 목록 가져오기
	$.getJSON("/event/getAttachList", {eventNo : <c:out value="${event.eventNo}"/>},
			function(result){
				console.log("attach list.........");
				console.log(result);	//console.log("attach list........." + result); 이런 식으로 쓰면 콘솔에 object라고 뜸
				
				//업로드된 결과를 화면에 섬네일 등을 만들어서 처리
					if(!result || result.length == 0){return;}
					
					var li = "";
					
					$(result.slice(0,1)).each(function(index, aFileDTO){	//첨부파일 array중 인덱스0번째(썸네일용)만 골라내기
//						$('.uploadResult ul').append('<li>' + aFileDTO.fileName + '</li>');
						//이미지가 아니면 attach.png 표시
						//클릭하면 다운로드
						aFileDTO.fileName = aFileDTO.fileName.substring(aFileDTO.fileName.indexOf(".")+1, aFileDTO.fileName.length);
						if(aFileDTO.fileType == false){
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/" + aFileDTO.uuid + "_" + aFileDTO.fileName);
							var fileLink = filePath.replace(new RegExp(/\\/g), "/");
							
							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/resources/img/attach.png'>"
								+ "</div></li>";
							
						}else{	
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/s_" + aFileDTO.uuid + "_" + aFileDTO.fileName);

							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/display?fileName=" + filePath + "'>"
								+ "</div></li>";
							
							//섬네일 클릭 시 showImage() 호출
//							var originPath = aFileDTO.uploadPath + "\\" + aFileDTO.uuid + "_" + aFileDTO.fileName;
//							originPath = originPath.replace(new RegExp(/\\/g), "/");	//역슬래시를 슬래시로 바꾸는 처리
						}
					});
					$("#thumbResult ul").append(li);
				
			}).fail(function(xhr, status, err){
				console.log(err);
			});
	
	
	
	
	
	//게시물 하나에 대한 첨부파일 목록 가져오기
	$.getJSON("/event/getAttachList", {eventNo : <c:out value="${event.eventNo}"/>},
			function(result){
				console.log("attach list.........");
				console.log(result);	//console.log("attach list........." + result); 이런 식으로 쓰면 콘솔에 object라고 뜸
				
				//업로드된 결과를 화면에 섬네일 등을 만들어서 처리
					if(!result || result.length == 0){return;}
					
					var li = "";
					
					$(result.slice(1,2)).each(function(index, aFileDTO){	//첨부파일 array중 인덱스1번째(상세정보용)만 골라내기
						//$('.uploadResult ul').append('<li>' + aFileDTO.fileName + '</li>');
						//이미지가 아니면 attach.png 표시
						//클릭하면 다운로드
						//if(aFileDTO.image == false){
						if(aFileDTO.fileType == false){
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/" + aFileDTO.uuid + "_" + aFileDTO.fileName);
							var fileLink = filePath.replace(new RegExp(/\\/g), "/");
							
							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/resources/img/attach.png'>"
								+ "</div></li>";
							
						}else{	
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/s_" + aFileDTO.uuid + "_" + aFileDTO.fileName);

							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/display?fileName=" + filePath + "'>"
								+ "</div></li>";
							
							//섬네일 클릭 시 showImage() 호출
							//var originPath = aFileDTO.uploadPath + "\\" + aFileDTO.uuid + "_" + aFileDTO.fileName;
							//originPath = originPath.replace(new RegExp(/\\/g), "/");	//역슬래시를 슬래시로 바꾸는 처리
						}
					});
					$("#detailResult ul").append(li);
				
			}).fail(function(xhr, status, err){
				console.log(err);
			});
	
	
	//응모버튼 클릭이벤트
	$("#eventApply").click(function() {
		alert("응모되었습니다! 참여주해주셔서 감사합니다.");
		document.getElementById("eventApply").style.visibility = "hidden";
	});
	
	

});	//END $



</script>
 

<%@ include file="../includes/footer.jsp" %>