<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>uploadAjax.jsp</title>
	<style>
		.uploadResult			{width:100%; 						background-color:gray;}
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
</head>
<body>
	<h1>UPLOAD WITH AJAX</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<hr>
	<input type="submit" value="upload" id="uploadBtn">
	
	<!-- 업로드 결과 출력 -->
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<!-- 썸네일 원본 이미지 출력 -->
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<script>
		// 섬네일 이미지 원본 표시
		function showImage(filePath){
			// alert(filePath);
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(filePath)+"'>")
							.animate({width:'100%', height:'100%'}, 1000); 
		}
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
			setTimeout( () -> {$(this).hide();}, 1000);
		});
	
	</script>
	
	<script>
		$(function() {
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;			// 5MB
			var uploadResult = $(".uploadResult ul");
		
		//	X 표시 클릭 이벤트 처리
			$(".uploadResult").on("click","span", function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				
				$.ajax({
					url : '/deleteFile',
					data : {fileName:targetFile, type:type},
					dataType : 'text',
					type : 'POST',
					success: function(result){
						alert("delete ok");
					},
					error: function(error){
						alert(error);
					}
				}); // End $.ajax
			});
		// End X 표시 클릭 이벤트 처리
			
			
		// 업로드 결과 출력
		function showUploadedFile(uploadResultArr) {
				var li = "";
				
				$(uploadResultArr).each(function(i, obj){
					if(obj.image == false) {						// 이미지가 아니면 attach.png 표시
				//		li += "<li>" + obj.fileName + "</li>";		
				//		var filePath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						var filePath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						li += "<li><a href='/download?fileName=" + filePath + "'>"+
							  "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>"+
							  "<span data-file='"+ filePath +"' data-type='file'>X</span></li>";
					} else {										// 이미지이면 섬네일 표시
						var filePath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						var originPath = obj.uploadPath + "\\" +obj.uuid +"_" + obj.fileName;
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						li += "<li><a href=\"javascript:showImage(\'"+ originPath +"\')\">"+
							  "<img src='/display?fileName=" + filePath + "'></a>"+
							  "<span data-file='"+ filePath + "' data-type='image'>X</span></li>";
					}
				});
				uploadResult.append(li);
			}
			
			//	첨부 파일 확장자 및 크기 확인 함수
			function checkExetension(fileName, fileSize) {
				// 파일 크기가 maxSize를 초과하는 경우
				if(fileSize > maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				// 파일 확장자가 exe, sh, zip, alz인 경우
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 할 수 없습니다.")
					return false;
				}
				return true;
			}	// End checkExetension()			
			
			var uploadDivClone = $('.uploadDiv').clone();				// 업로드 영역 복제
			
			$("#uploadBtn").on("click", function(e){					// uploadBtn 이벤트 처리
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				
				console.log(files);
				
				for(var i=0; i<files.length; i++) {
					if(!checkExetension(files[i].name, files[i].size)){
						return false;
					}
					formData.append('uploadFile', files[i]);
				}
				
				$.ajax({
					type : 'POST',
					url  : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					dataType : 'json',
					success : function(result){
						alert("Upload Ok!");
						console.log(result);
						
						showUploadedFile(result);
						
						 $('.uploadDiv').html(uploadDivClone.html());						
					},
					error : function(xhr, status, err) {
						alert("Upload Not OK!!!");
					}
				});	// $.ajax
				
				
			});	//	End uploadBtn()
		});
	
	</script>
</body>
</html>