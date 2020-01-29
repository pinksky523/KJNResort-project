<%@page import="org.apache.ibatis.executor.ReuseExecutor"%>
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
</style>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
        	<!-- Tables -->
        	후기 등록1
        </h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <!-- DataTables Advanced Tables -->
                <!-- Board List Page -->
                	후기 등록2
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
			<form method="post" action="/review/register" role="form">
			<input type="hidden" name="${_csrf.parameterName }"
 					             value="${_csrf.token }">
	            <div class="form-group">
	                <label>제목</label>
	                <input class="form-control" name="title"></div>
	            <div class="form-group">
	                <label>카테고리</label>
	                 <select name="category" class="form-control" id="category"  style="width: 70%">
        				<option value="스키">스키 </option>
        				<option value="콘도">콘도 </option>
			        	<option value="기타">기타 </option> </select></div>
	            <div class="form-group">
	                <label>평점</label>
	                 <select name="grade" class="form-control" id="grade"  style="width: 70%">
        				<option value="1">1 </option>
        				<option value="2">2 </option>
        				<option value="3">3 </option>
        				<option value="4">4 </option>
			        	<option value="5">5 </option> </select></div>			        	    
	            <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content"></textarea></div>
                <input type="hidden" name="useNo" value="${useNo}">
                <input type="hidden" name="ticketNo" value="${useNo}">
                <sec:authorize access="isAuthenticated()">
        			<input type="hidden" name="id" value="<sec:authentication property="principal.username"/>">
    			</sec:authorize>
	            <button type="submit" class="btn btn-default">
	            	Submit Button</button>
                <button type="reset" class="btn btn-default">
                	Reset Button</button>
			</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<!-- 첨부파일  -->
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
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->
<!-- END 첨부파일  -->

<script>
$(function(e){

	$("button[type='submit']").click(function(e){
		e.preventDefault();
		console.log('submit clicked!');
		
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
		console.log(tags);
		$("form[role='form']").append(tags).submit();
	});
	
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
			type		: 'POST',
			url			: '/uploadAjaxAction',
			data		: formData,
			dataType	: 'json',
			contentType	: false,
			processData : false,
			beforeSend	: function(xhr){ //전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success		: function(result){
				console.log(result);
				showUploadedFile(result);
			},
			error		: function(error){
				alert('upload not ok');
			}
		});//END .ajax()
	});//END 첨부 파일 클릭 이벤트 처리 
	
	//업로드 결과 출력
	function showUploadedFile(result){
		var li = '';

		$(result).each(function(index, obj){
			if(obj.image == false){	//이미지가 아니면 attach.png 표시
				var filePath = encodeURIComponent(
									obj.uploadPath + "/" + 
									obj.uuid + "_" +
									obj.fileName);
				li += "<li data-path='" + obj.uploadPath + "' " + 
					  "    data-uuid='" + obj.uuid + "' "+
					  "    data-filename='" + obj.fileName + "' " +
					  "    data-type='" + obj.image + "'>" +
				      "    <div><span>" + obj.fileName + "</span>" +
					  "    <button type='button' " +
					  "            class='btn btn-warning btn-circle'" +
					  "            data-file='" + filePath +"' " +
					  "	           data-type='file'>" + 
					  "        <i class='fa fa-times'></i></button><br>" +
				  	  "    <img src='/resources/img/attach.png'></div></li>";
			} else { //이미지이면 섬네일 표시
				var filePath = encodeURIComponent(obj.uploadPath + "/s_" +
												  obj.uuid + "_" + obj.fileName);
				var originPath = obj.uploadPath + "\\" + 
								 obj.uuid + "_" + obj.fileName;
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
					  "    <img src='/display?fileName=" + filePath + "'></div></li>";   			}
		});
		$('.uploadResult ul').append(li);
	}//END showUploadedFile() 업로드 결과 출력
	
	//X 표시 버튼 클릭 이벤트 처리
	$('.uploadResult').on('click', 'button', function(e){
		var targetFile = $(this).data('file');
		var type = $(this).data('type');
		var targetLi = $(this).closest('li');

		$.ajax({
			type		: 'POST',
			url			: '/deleteFile',
			data		: { fileName:targetFile, type:type },
			dataType	: 'text',
			beforeSend	: function(xhr){ //전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success		: function(result){
				targetLi.remove();
			},
			error		: function(error){
				alert(error);
			}
		});//END .ajax()
	}); //END X 표시 클릭 이벤트 처리
});//END $
</script>
<%@ include file="../includes/footer.jsp" %>
















