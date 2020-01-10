<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../includes/header.jsp" %>

<style>

	.uploadResult{width: 100%; background: lightblue;}
	.uploadResult ul{display : flex; flex-flow : row; justify-content: center; align-items: center;}
	.uploadResult ul li{list-style : none; padding: 10px; align-content: center; text-align: center;}
	.uploadResult ul li img{width: 100px}
	.uploadResult ul li span{color:white;}
	.bigPictureWrapper{position: absolute; display: none; justify-content: center; align-items: center;
					   top: 0%; width: 100%; height: 100%; background-color: gray; z-index: 100; background: rgba(255,255,255,0.5)}
	.bigPicture{position: relative; display: flex; justify-content: center; align-items: center;}
	.bigPicture img {width: 600px;}

</style>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
        	<!-- Tables -->
        	Board Register	
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
                Board Register
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
			<form method="post" action="/board/register" role="form">
	            <div class="form-group">
	                <label>Title</label>
	                <input class="form-control" name="title"></div>
	            <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content"></textarea></div>
	            <div class="form-group">
	                <label>Writer</label>
	                <input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly></div>
	            <button type="submit" class="btn btn-default">
	            	Submit Button</button>
                <button type="reset" class="btn btn-default">
                	Reset Button</button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<div class="row">			<!-- 첨부 파일-->
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"> File Attach</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
				</div>
				<div class="uploadResult">
					<ul>

					</ul>
				</div>
			</div>
		</div>
	</div>
</div>						<!-- END 첨부 파일 -->

<script>

	$(function(e){
		var formObj = $("form[role = 'form']");
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			console.log("submit clicked!");
			
			var tags="";

			$(".uploadResult ul li").each(function(i, obj){

				var jobj = $(obj);

				console.dir(jobj);

				tags += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
				tags += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";

			});	// End each
			console.log(tags);
			formObj.append(tags).submit();
		});

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
		}	//END checkExetension

		// CSRF 토큰 관련 변수 추가
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(function(){	//업로드 버튼 이벤트 처리

			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;

			for(var i=0; i < files.length; i++){
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
				beforeSend  : function(xhr) {				// 전송 전 추가 헤더 설정
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : formData,
				dataType : 'json',
				success : function(result){
					console.log(result);
					alert('ok');				
					showUploadedFile(result);				// 업로드 결과 처리 함수
//					$("input[type='file']").html("");
				},
				error : function(err){
					alert('Not ok');
				}
			}); 	 	
		});

		//X표시 클릭 이벤트 처리
		
	 	$('.uploadResult').on("click","button",function(e){
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");

	 		$.ajax({
				url : '/deleteFile',
				data : {fileName: targetFile, type:type},
				beforeSend  : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				dataType : 'text',
				type : 'post',
				success : function(result){
					alert(result);
					targetLi.remove();
				},
				error : function(error){
					alert('delete not ok');
				}
			});	//$.ajax 
		});	 //END X 표시 클릭 이벤트 처리
				
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

				}else{ //이미지이면 그대로 표시

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
	});//END $

</script>

<%@ include file="../includes/footer.jsp" %>