<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<%@ include file="../includes/header.jsp" %>
<style>
	.uploadResult			{width:100%; 						background-color: lightblue;}
	.uploadResult ul		{display:flex; flex-flow: row; justify-content: center; align-items: center;}	
	.uploadResult ul li		{list-style: none; padding: 10px; align-content: center; text-align: center;}
	.uploadResult ul li img	{width: 100px;}
	.uploadResult ul li span{color: white;}
	.bigPictureWrapper		{position: absolute; 				display: none; 
					    	 justify-content: center; 			align-items: center;
					    	 top: 0%;							width: 100%; 					 	
					    	 height: 100%; 					    background-color: gray; 		
					    	 z-index: 100; 					    background: rgba(255,255,255,0.5);}	
	.bigPicture				{position: relative; 				display: flex; 
							 justify-content: center; 			align-items: center;}	
	.bigPicture img			{width: 600px;}
</style>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Modify Page</h1>
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
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
	             		<c:if test="${pinfo.username eq board.writer }">
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
<div class="bigPictureWrapper">	<!-- 이미지 클릭시 이미지를 크게해서 출력하는 부분 -->
	<div class="bigPicture">
	</div>
</div>

<div class="row">			<!-- 첨부파일 -->
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"> File Attach</div>
			<div class="panel-body">
			 	<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>	<!-- 첨부파일을 등록하는 영역 -->
				</div>
				<div class="uploadResult">							<!-- 첨부 파일이 나오는 영역 -->
					<ul>

					</ul>
				</div>
			</div>
		</div>
	</div>
</div>						<!-- END 첨부 파일 -->

<script>
//즉시 실행 함수 - 첨부파일 목록 가져오기
(function(){
	var bno = '<c:out value="${board.bno}"/>';
	$.getJSON("/board/getAttachList", {bno:bno}, function(result){
			console.log('----- attach list -----');
			console.log(result);
			var str ="";

			$(result).each(function(i, obj){
				if(obj.fileType == false){								//이미지가 아니면 attach.png 표시
					var filePath = encodeURIComponent(obj.uploadPath + "/" + 
													  obj.uuid + "_" + 
													  obj.fileName);

						str += "<li data-path='" + obj.uploadPath + "'" +
							   "	data-uuid='" + obj.uuid + "'" +
							   " 	data-filename='" + obj.fileName + "'" + 
							   "	data-type='" +  obj.fileType + "'>"
						str += "<div>";
						str += "<span> " + obj.fileName + "</span><br>";
						str += "<button data-file=\'" + filePath + "\' data-type='file' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
				} else { 												//이미지이면 그대로 표시
					var filePath = encodeURIComponent(obj.uploadPath + "/s_" + 
													  obj.uuid + "_" +
													  obj.fileName);

						str += "<li data-path='" + obj.uploadPath + "'" +
					  	       "	data-uuid='" + obj.uuid + "'" +
					 	       " 	data-filename='" + obj.fileName + "'" + 
					  	       "	data-type='" +  obj.fileType + "'>"						
					    str += "<div>";
						str += "<span> " + obj.fileName + "</span>";
						str += "<button data-file=\'" + filePath + "\' data-type='image' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + filePath + "'>";
						str += "</div>";
						str += "</li>";
				}
			});
			$(".uploadResult ul").append(str);
			
			
	}).fail(function(xhr, status, err){
		if(error)	{
			console.log(err);
		}
	});
	
})();	//END 즉시 실행함수 - 첨부파일 목록 가져오기

//X표시 클릭 이벤트 처리
	$('.uploadResult').on("click","button",function(e){
		console.log("delete file");
		if(confirm("Remove this file?")) {
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
		
	});

$('button').on('click', function(e){
	e.preventDefault();
});

$(function(){
	var frm = $('form');
	
	$('button').click(function(e){
		e.preventDefault();
		
		var oper = $(this).data('oper');
		
		if(oper === 'remove') {			// 삭제 버튼
			frm.attr('action', '/board/remove');
			frm.submit();
		} else if(oper === 'list'){		// 목록 버튼
			var pageNumTag = $("input[name='pageNum']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			frm.attr('action', '/board/list')
			   .attr('method', 'get')
			   .empty();
			frm.append(pageNumTag)
			   .append("<input type='hidden' name='amount' value='" +
						${cri.amount} + "'>")
			   .append(typeTag)
			   .append(keywordTag);
			frm.submit();
		} else if(oper === 'modify'){	// 수정 버튼
			var tags="";
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				tags += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";

			});	// End each
			console.log(tags);
			frm.append(tags).submit();
		//	frm.submit();
		}
		
	});
});

// 첨부파일의 확장자 및 파일크기 확인
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880; 

function checkExetension(fileName, fileSize){
	//파일 크키가 maxSize를 초과하는 경우
	if(fileSize > maxSize){ 
		alert("파일 용량이 너무 큽니다.");
		return false;
	}
	//파일 확장자가 exe, sh, zip, alz인 경우
	if(regex.test(fileName)){
		alert("해당 종류의 파일을 업로드 할 수 없습니다.");
		return false;
	}
	return true;
}//END checkExetension

//CSRF 토큰 관련 변수 추가
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$("input[type='file']").change(function(){			//업로드 버튼 이벤트 처리

	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;

	for(var i=0; i<files.length; i++){
		if(!checkExetension(files[i].name, files[i].size)){
			return;
		}
		formData.append('uploadFile', files[i]);
	}
		$.ajax({
		type : 'post',
		url : '/uploadAjaxAction',
		contentType : false,
		processData : false,
		data : formData,
		beforeSend  : function(xhr) {				// 전송 전 추가 헤더 설정
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		dataType : 'json',
		success : function(result){
			console.log(result);
			alert('ok');
			showUploadedFile(result);				// 업로드 결과 처리 함수
//			$("input[type='file']").html("");
		},
		error : function(err){
			alert('Not ok');
		}
	}); 	 	
});

function showUploadedFile(result){	//파일 업로드명 추가
	var str ="";

	$(result).each(function(i, obj){
		if(!obj.image){ //이미지가 아니면 attach.png 표시
		//str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
			var filePath = encodeURIComponent(obj.uploadPath + "/" + 

											  obj.uuid + "_" + 

											  obj.fileName);

				str += "<li data-path='" + obj.uploadPath + "'" +

					   "	data-uuid='" + obj.uuid + "'" +

					   " 	data-filename='" + obj.fileName + "'" + 

					   "	data-type='" +  obj.image + "'>"
				str += "<div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button data-file=\'" + filePath + "\' data-type='file' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div>";
				str += "</li>";

		} else { //이미지이면 그대로 표시

			//str += "<li>" + obj.fileName + "</li>";		

			var filePath = encodeURIComponent(obj.uploadPath + "/s_" + 

											  obj.uuid + "_" +

											  obj.fileName);

				str += "<li data-path='" + obj.uploadPath + "'" +
			  	       "	data-uuid='" + obj.uuid + "'" +
			 	       " 	data-filename='" + obj.fileName + "'" + 
			  	       "	data-type='" +  obj.image + "'>"						
			    str += "<div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button data-file=\'" + filePath + "\' data-type='image' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName=" + filePath + "'>";
				str += "</div>";
				str += "</li>";
		}
	});
	$(".uploadResult ul").append(str);
}

</script>
<%@ include file="../includes/footer.jsp" %>

