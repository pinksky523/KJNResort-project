<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<sec:authentication property="principal" var="pinfo"/>
<c:choose>
	<c:when test="${pinfo.username eq 'admin'}">
		<%@ include file="../includes/adminHeader.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="../includes/header.jsp" %>
	</c:otherwise>
</c:choose>
<style>
.modall {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modall-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .closee {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .closee:hover,
        .closee:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
		
		#btnDiv {
			text-align: center;
			margin: 10px;
		}
</style>
        <h2>이벤트</h2>
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
         <th>&nbsp</th>
         <td style="width: 33%"><input style="font-weight: bold;" type="text" name="title" class="form-control" id="inputTitle" value="${event.title}" readonly></td>
         <td></td>
       </tr>
       <tr><td>&nbsp</td></tr>
        <tr>
         <th>&nbsp</th>
         <td>
         <label>기간 : &nbsp</label>${event.eventStart} ~ ${event.eventEnd}
         <label style="float: right;">조회수 : &nbsp ${event.viewCnt}</label>
        
         </td>
       </tr>
       <tr><td>&nbsp</td></tr>
      												
           
           </table>
          
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
	            <c:if test="${pinfo.username eq 'admin'}">	<!-- 내가 작성한 글인가?  -->
	            	<button data-oper="modify" class="btn btn-warning" id="eventModify">수정</button>
	            </c:if>
	            
	            
	            <sec:authorize access="isAuthenticated()">	<!-- 로그인을 했나? -->
	            <sec:authentication property="principal" var="pinfo"/>
	            <c:if test="${pinfo.username eq 'admin'}">	<!-- 내가 작성한 글인가?  -->
	            
	            	<button data-oper="delete" class="btn btn-danger" id="eventDelete">삭제</button>
	            	
	            </c:if>
	             </sec:authorize>
	            
	            <sec:authorize access="isAuthenticated()">	<!-- 로그인을 했나? -->
	            <c:if test="${pinfo.username ne 'admin'}">	<!-- 내가 작성한 글인가?  -->
	            	<button data-oper='apply' class="btn btn-success" id="eventApply">응모하기</button>
	            </c:if>
	            </sec:authorize>
	   			                   
</div>		
<form method="post" name="frm" id="deleteForm" action="/event/remove">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="eventNo" value="${event.eventNo}">
	<input type="hidden" name="pageNum" value="${cri.pageNum}">
	<input type="hidden" name="amount" value="${cri.amount}">
</form>
      
<form action="/event/modify" id="operForm">
	<input type="hidden" id="eventNo" name="eventNo" value="${event.eventNo}">
	<input type="hidden" name="pageNum" value="${cri.pageNum}">
	<input type="hidden" name="amount" value="${cri.amount}">
</form> 



 
    <!-- The Modal -->
    <div id="myModall" class="modall">
 
      <!-- Modal content -->
      <div class="modall-content" style="width: 200px; height: 180px;">
        <span class="closee">&times;</span>                                                               
     	  <label>정답을 입력해주세요</label>
		<input class="form-control" id="answer">
      	<div id="btnDiv">
	 		<button id="modalCloseBtn" class="btn btn-default" data-dismiss="modall">Close</button>	<!-- data-dismiss 넣으면 이벤트 처리 따로 하지 않아도 됨 -->
	        <button id="modalApplyBtn" data-oper="modalApply" class="btn btn-primary">응모</button>
        </div>
         </div>
    </div>





<script>
$(function(e){
    var modal = document.getElementById('myModall');
    var span = document.getElementsByClassName("closee")[0];                                          

    //응모하기 버튼 클릭이벤트
    $("#eventApply").click(function() {
    	modal.style.display = "block";
    });

    //X표시 클릭이벤트
    span.onclick = function() {
        modal.style.display = "none";
    }

    //모달창 닫기버튼 클릭이벤트
    $("#modalCloseBtn").click(function() {
        modal.style.display = "none";
    });
    
    //외부영역 클릭이벤트
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
	
	
	var operForm = $("#operForm");
	
	//수정버튼 클릭이벤트
	$("button[data-oper='modify']").on("click", function(e){
		operForm.submit();
	});
	
	//삭제버튼 클릭이벤트
	$("button[data-oper='delete']").on("click", function(e){
		if(confirm("정말 삭제하시겠습니까?")) {
			$("#deleteForm").submit();
		}
	});
	
	//모달창 응모하기버튼 클릭이벤트
	$("button[data-oper='modalApply']").on("click", function(e){
		var answer = document.getElementById("answer").value;
		
		if(answer!=""){
			alert("이벤트에 응모되셨습니다! 참여해주셔서 감사합니다");
			modal.style.display = "none";
		} else if(answer == null || answer === ""){
			alert("정답을 입력해주세요");
			$("#answer").focus();
		}
		
		
	});
	
		
		
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
	
	

});	//END $



</script>
 

<%@ include file="../includes/footer.jsp" %>