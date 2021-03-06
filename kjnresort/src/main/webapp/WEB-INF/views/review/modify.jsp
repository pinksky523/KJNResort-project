<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<style>
.uploadResult { width:100%; 				background: #efe; }
.uploadResult ul { 	display:flex; 			flex-flow:row;
					justify-content: center;align-items: center;}
.uploadResult ul li {	list-style: none;	padding:10px; }
.uploadResult ul li img { width:100px; }
.uploadResult ul li span { color:gray;  }
.bigPcitureWrapper { position: absolute;		display:none;
					 justify-content: center;	align-items: center;
					 top: 0%;					z-index: 100;
					 width:100%;				height:100%;
					 background: gray; }
.bigPicture { 	position: relative;		display: flex;
				justify-content: center;align-items: center; }
.bigPicture img { width: 600px; }
.info_div{ align-self: center;  width:1300px; margin:0 auto; margin-top:30px; background: #EAEAEA; padding:40px;}

h2{text-align: center;}
hr{text-align: center; width:1000px;}
</style>

        <h2 class="page-header">
        	후기 수정
        </h2>
        <hr>

<!-- /.row -->
<div class="info_div">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <!-- /.panel-heading -->
            <div class="panel-body">
			<form method="post" action="/review/modify" role="form">
				<input type="hidden" name="${_csrf.parameterName }"
	 					             value="${_csrf.token }">
               	<input type="hidden" name="pageNum" value="${cri.pageNum}">
               	<input type="hidden" name="amount" value="${cri.amount}">
               	<!-- 검색 조건과 키워드 파라미터 추가 -->
               	<input type="hidden" name="type" value="${cri.type}">
               	<input type="hidden" name="keyword" value="${cri.keyword}">
               	<input type="hidden" name="reviewNo" value="${review.reviewNo}">
	            <div class="form-group">
	                <label>제목</label>
	                <input class="form-control" name="title"
	                	   value="${review.title }" ></div>
	            <div class="form-group">
	                <label>카테고리</label>
	                 <select name="category" class="form-control" id="category"  style="width: 50%">
        				<option value="스키">스키 </option>
        				<option value="콘도">콘도 </option>
			        	<option value="기타">기타 </option> </select></div>
	            <div>
                    <label>작성자</label>
                    <input class="form-control" name="id" readonly value="${review.id }"></div>
	            <div>
	                <label>조회수</label>
	                <input class="form-control" name="veiwCnt" readonly 
	                	   value="${review.viewCnt }"></div>
	           <div>
                    <label>작성일시</label>
                    <textarea class="form-control" rows="1" 	
	                	      readonly><fmt:formatDate value="${review.regdate}"
                            					pattern="yyyy-MM-dd"/></textarea></div>
	            <div class="form-group">
	                <label>평점</label>
	                 <select name="grade" class="form-control" id="grade"  style="width: 50%">
        				<option value="1">1 </option>
        				<option value="2">2 </option>
        				<option value="3">3 </option>
        				<option value="4">4 </option>
			        	<option value="5">5 </option> </select></div>
	            <div class="form-group">
                    <label>내용</label>
                    <textarea class="form-control" rows="3" name="content"
	                	      >${review.content }</textarea></div>     	   
	                	  
	            <!-- 로그인한 사용자가 작성한 글에만 수정/삭제 버튼 표시 -->
	            <sec:authentication property="principal" var="pinfo"/>
	            <sec:authorize access="isAuthenticated()">
	            	<c:if test="${pinfo.username == review.id }">
			            <button data-oper='modify' class="btn btn-warning pull-right">
			            	수정</button>
	            	</c:if>
	            </sec:authorize>    	   
				<button data-oper='list' class="btn btn-secondary pull-right">취소</button>
			</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
				<!-- /.row -->

 
<!-- START 첨부파일  -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">File Attch</div>
            <div class="panel-body">
	            <div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				
				<!-- 업로드 결과  출력 -->
				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
				
				<!-- 섬네일 원본 이미지 출력 -->
				<div class='bigPcitureWrapper'>
					<div class='bigPicture'>
					</div>
				</div>
				<!-- END 섬네일 원본 이미지 출력 -->
            </div>	
        </div>		
    </div>			
</div>				
<!-- END 첨부파일 --> 	 
</div>

<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue="${_csrf.token}";
//X 표시 버튼 클릭 이벤트 처리
$('.uploadResult').on('click', 'button', function(e){
	if(confirm("파일을 삭제하시겠습니까?")){
		var targetLi = $(this).closest('li');
		
		var targetFile = $(this).data('file');
		
		targetLi.remove();
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile},
			type: 'POST',
			dataType: 'text',
			beforeSend: function(xhr){//전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result){
				alert('임시업로드 파일 삭제 성공');
				targetLi.remove();
			},
			error: function(error){
				alert('임시업로드 파일 삭제 실패');
			}
		});	//END $.ajax
	}
}); //END X 표시 클릭 이벤트 처리

$(function(){
	var frm = $('form');
	
	$('button').click(function(e){
		e.preventDefault();
		
		var oper = $(this).data('oper');
		
		if(oper === 'remove') {			//삭제 버튼
			frm.attr('action', '/review/remove');
			frm.submit();
		}else if(oper === 'list'){		//목록 버튼
			var pageNumTag = $("input[name='pageNum']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			frm.attr('action', '/review/list').attr('method', 'get').empty();
			
			frm.append(pageNumTag)
			   .append("<input type='hidden' name='amount' value='" +
						${cri.amount} + "'>")
			   .append(typeTag)
			   .append(keywordTag);
			frm.submit();
		}else if(oper === 'modify'){	//수정 버튼
			var tags = "";
			 $('.uploadResult ul li').each(function(i, obj){
				var o = $(obj);
				tags += "<input type='hidden' name='attachList[" + i + "].fileName' " +
						"       value='" + o.data('filename') + "'>";
				tags += "<input type='hidden' name='attachList[" + i + "].uuid' " +
						"       value='" + o.data('uuid') + "'>";
				tags += "<input type='hidden' name='attachList[" + i + "].uploadPath' " +
						"       value='" + o.data('path') + "'>";
			});//END each() 
			frm.submit();
			//frm.submit();
		}
	});//END 버튼 클릭 이벤트 처리
	
	//첨부 파일 확장자 및 크기 확인
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	
	//첨부 파일 확장자 및 크기 확인 함수
	function checkExtension(fileName, fileSize){
		if(fileSize > maxSize){ //파일 크기가 maxSize를 초과하는 경우
			alert('업로드 파일 사이즈가 초과되었습니다.');
			return false;
		}
		
		if(regex.test(fileName)){		//파일 확장자가 exe, sh, zip, alz인 경우 
			alert('업로드 할 수 없는 파일입니다.');
			return false;
		}
		return true;
	}//END checkExetension()
	
	var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수 추가
	var csrfTokenValue = '${_csrf.token}';
	
	//첨부 파일 클릭 이벤트 처리 	
	$("input[type='file']").change(function(){			
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(f of files){
			if(!checkExtension(f.name, f.size)){
				return false;
			}
			formData.append('uploadFile', f);
		}
		
		$.ajax({
			type		: 'POST',		url			: '/uploadAjaxAction',
			data		: formData,		dataType	: 'json',
			contentType	: false,		processData : false,
			beforeSend	: function(xhr){ 	//전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success		: function(result){	showUploadedFile(result);  },
			error		: function(error){  alert('upload not ok');  }
		});//END .ajax()
	});//END 첨부 파일 클릭 이벤트 처리 
	
	//즉시 실행함수 
	 (function(){
		//첨부파일 목록 가져오기
		$.getJSON("/review/getAttachList", { reviewNo : '${review.reviewNo}' }, function(result){
			console.log('attach list----------------');
			console.log(result);
			var li = '';

			$(result).each(function(index, obj){
					var filePath = encodeURIComponent(obj.uploadPath + "/s_" +
													  obj.uuid + "_" + 
													  obj.fileName);
					var originPath = obj.uploadPath + "\\" + 
									 obj.uuid + "_" + 
									 obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g), "/");

					li += "<li data-path='" + obj.uploadPath + "' " + 
						  "    data-uuid='" + obj.uuid + "' "+
						  "    data-filename='" + obj.fileName + "' >" +
						  "    <button type='button' " +
						  "            class='btn btn-warning btn-circle'" +
						  "            data-file='" + filePath +"' " +
						  "	           data-type='file'>" + 
						  "		<i class='fa fa-times'></i></button><br>" +
						  "    <img src='/display?fileName=" + filePath + "'></div></li>";   			
				});//END each()
				$('.uploadResult ul').append(li);
		}).fail(function(xhr, status, err){
			console.log(err);
		}); //END 첨부파일 목록 가져오기
	})(); //END 즉시 실행함수 
	
	//업로드 결과 출력
	function showUploadedFile(result){
		var li = '';
		$(result).each(function(index, obj){
			var filePath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
	        var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g), "/");

				li += "<li data-path='" + obj.uploadPath + "' " + 
					  "    data-uuid='" + obj.uuid + "' "+
					  "    data-filename='" + obj.fileName + "' " +
					  "    data-type='" + obj.image + "'>" +
				      "    <div><span>" + obj.fileName + "</span>" + 
				      "    <button type='button' " + 
				      "            class='btn btn-warning btn-circle'" +
				      "            data-file='" + filePath +"' " +
					  "	           data-type='image'>" +
				      "        <i class='fa fa-times'></i></button><br>" + 
					  "    <img src='/display?fileName=" + filePath + "'></div></li>";   	
		});
		$('.uploadResult ul').append(li);
	}//END showUploadedFile() 업로드 결과 출력
});
</script>
<%@ include file="../includes/footer.jsp" %>














