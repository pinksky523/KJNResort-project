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
        	Board Modify Page	
        </h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board Modify Page	
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
			<form method="post" action="/board/modify" role="form">
				<input type="hidden" name="${_csrf.parameterName }"
	 					             value="${_csrf.token }">
               	<input type="hidden" name="pageNum" value="${cri.pageNum}">
               	<input type="hidden" name="amount" value="${cri.amount}">
               	<!-- 검색 조건과 키워드 파라미터 추가 -->
               	<input type="hidden" name="type" value="${cri.type}">
               	<input type="hidden" name="keyword" value="${cri.keyword}">
               	
	            <div class="form-group">
	                <label>Bno</label>
	                <input class="form-control" name="bno" readonly
	                	   value="${board.bno }" ></div>
	            <div class="form-group">
	                <label>Title</label>
	                <input class="form-control" name="title"
	                	   value="${board.title }" ></div>
	            <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content"
	                	      >${board.content }</textarea></div>
	            <div class="form-group">
	                <label>Writer</label>
	                <input class="form-control" name="writer" readonly 
	                	   value="${board.writer }"></div>
	                	   
	            
	            <!-- 로그인한 사용자가 작성한 글에만 수정/삭제 버튼 표시 -->
	            <sec:authentication property="principal" var="pinfo"/>
	            <sec:authorize access="isAuthenticated()">
	            	<c:if test="${pinfo.username == board.writer }">
			            <button data-oper='modify' class="btn btn-default">
			            	Modify</button>
			            <button data-oper='remove' class="btn btn-danger">
			            	Remove</button>
	            	</c:if>
	            </sec:authorize>    	   
                <button data-oper='list' class="btn btn-info">
                	List</button>
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
				
				<!-- 섬네일 원본 이미지 출력 -->
				<div class='bigPcitureWrapper'>
					<div class='bigPicture'>
					</div>
				</div>
				<!-- END 섬네일 원본 이미지 출력 -->
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->
<!-- END 첨부파일  -->	 

<script>
//즉시 실행함수 
(function(){
	
	//첨부파일 목록 가져오기
	$.getJSON("/board/getAttachList", 
			  { bno : ${board.bno} }, 
			  function(result){
		console.log('attach list----------------');
		console.log(result);
		var li = '';

		var li = '';

		$(result).each(function(index, obj){
			if(obj.fileType == false){	//이미지가 아니면 attach.png 표시
				var filePath = encodeURIComponent(
									obj.uploadPath + "/" + 
									obj.uuid + "_" +
									obj.fileName);
				li += "<li data-path='" + obj.uploadPath + "' " + 
					  "    data-uuid='" + obj.uuid + "' "+
					  "    data-filename='" + obj.fileName + "' " +
					  "    data-type='" + obj.fileType + "'>" +
				      "    <div><span>" + obj.fileName + "</span>" +
				      "    <button type='button' " + 
				      "            class='btn btn-warning btn-circle'" +
				      "            data-file='" + filePath +"' " +
					  "	           data-type='image'>" +
				      "        <i class='fa fa-times'></i></button><br>" + 
				  	  "    <img src='/resources/img/attach.png'></div></li>";
			} else { //이미지이면 섬네일 표시
				var filePath = encodeURIComponent(obj.uploadPath + "/s_" +
												  obj.uuid + "_" + 
												  obj.fileName);
				var originPath = obj.uploadPath + "\\" + 
								 obj.uuid + "_" + 
								 obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g), "/");

				li += "<li data-path='" + obj.uploadPath + "' " + 
					  "    data-uuid='" + obj.uuid + "' "+
					  "    data-filename='" + obj.fileName + "' " +
					  "    data-type='" + obj.fileType + "'>" +
				      "    <div><span>" + obj.fileName + "</span>" +
					  "    <button type='button' " +
					  "            class='btn btn-warning btn-circle'" +
					  "            data-file='" + filePath +"' " +
					  "	           data-type='file'>" + 
					  "        <i class='fa fa-times'></i></button><br>" +
					  "    <img src='/display?fileName=" + filePath + "'></div></li>";   			}
			});//END each()
			$('.uploadResult ul').append(li);
	}).fail(function(xhr, status, err){
		console.log(err);
	}); //END 첨부파일 목록 가져오기
})(); //END 즉시 실행함수 

//X 표시 버튼 클릭 이벤트 처리
$('.uploadResult').on('click', 'button', function(e){
	if(confirm("파일을 삭제하시겠습니까?")){
		var targetLi = $(this).closest('li');
		targetLi.remove();
	}
}); //END X 표시 클릭 이벤트 처리

$(function(){
	var frm = $('form');
	
	$('button').click(function(e){
		e.preventDefault();
		
		var oper = $(this).data('oper');
		
		if(oper === 'remove') {			//삭제 버튼
			frm.attr('action', '/board/remove');
			frm.submit();
		}else if(oper === 'list'){		//목록 버튼
			var pageNumTag = $("input[name='pageNum']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			frm.attr('action', '/board/list').attr('method', 'get').empty();
			
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
				tags += "<input type='hidden' name='attachList[" + i + "].fileType' " +
						"       value='" + o.data('type') + "'>";
			});//END each()
			console.log(tags);
			frm.append(tags).submit();
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
});
</script>
<%@ include file="../includes/footer.jsp" %>














