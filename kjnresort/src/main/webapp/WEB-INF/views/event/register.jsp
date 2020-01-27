<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

        <h2>이벤트 등록</h2>
<form role="form" id="joinForm" name="frm" method="post" action="/event/register">
<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
           <div style="text-align: center;">
               4계절을 골고루 즐기는 행복과 웃음으로 가득한 KJN리조트 이벤트입니다.
            </div>
            <hr style="width: 100% !important;">
            <!-- /.panel-heading -->
            <div class="panel-body">
		
   		<table style="padding:5px 0 5px 0; table-layout: fixed;">
      
       <tr>
         <th>제목</th>
         <td><input type="text" name="title" class="form-control" id="inputTitle"></td>
         <td></td>
       </tr>
       <tr><td>&nbsp</td></tr>
        <tr>
         <th>기간</th>
         <td colspan="2" align="center">
         <div style="display: inline;">
         <input type="date" class="form-control" name="eventStart" id="inputEventStart">
        ~
         <input type="date" class="form-control" name="eventEnd" id="inputEventEnd">
         </div>
         </td>
       </tr>
       <tr><td>&nbsp</td></tr>
        <tr>
         <th>이미지파일 (썸네일용)</th>
         <td><input type="file" class="form-control" name="uploadFile" id="uploadThumb"></td>
          <td></td>
       </tr>	
       <tr><td>&nbsp</td></tr>														
       <tr>
         <th>이미지파일 (상세정보용)</th>
         <td><input type="file" class="form-control" name="uploadFile" id="uploadDetail"></td>
          <td></td>
       </tr><tr><td>&nbsp</td></tr>
           
           </table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<!-- 첨부파일 -->
<!-- 파일 첨부하는 순간 업로드 할 수 있게 (따로 업로드 버튼 없음) -->
<div class="row" style="width: 50%; float: left;">
      <div class="col-lg-12">
             <div class="panel panel-default">
                 <div class="panel-heading">
                 	썸네일용 이미지
             	 </div>
	             <div class="panel-body">
	                  <div id="thumb" class="form-group uploadDiv">
	                      
	                  </div>
	                  <div id="thumbResult" class="uploadResult" style="height: 300px;">
	                      <ul>
	                      </ul>
	                  </div>
	             </div>
          </div>
     </div>
</div>
<div class="row" style="width: 50%; float: left;">
      <div class="col-lg-12">
             <div class="panel panel-default">
                 <div class="panel-heading">
                 	상세정보용 이미지
             	 </div>
	             <div class="panel-body">
	                  <div id="detail" class="form-group uploadDiv">
	                      
	                  </div>
	                  <div id="detailResult" class="uploadResult" style="height: 300px;">
	                      <ul>
	                      </ul>
	                  </div>
	             </div>
          </div>
     </div>
</div>
<div style="text-align: center;">
	<button type="button" class="btn btn-secondary" id="eventCancel" onclick="location.href='/event/list'">취소</button>
	<button type="submit" data-oper="register" class="btn btn-primary" id="eventRegister">등록</button>
</div>		      
</form>
<script>
$(function(e){
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").click(function(e){
		e.preventDefault();
		
		var str1 = "";
		var str2 = "";
		
		//Submit 버튼을 누르면 이미 업로드된 항목들을 세부적으로 <input type='hidden'> 태그들로 만들어서 <form> 태그가 submit될 때 같이 전송되도록 함
		//BoardVO에서 첨부파일의 정보 수집(attachList)
		$("#thumbResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			str1 += "<input type='hidden' name='attachList[0].fileName' value='" + jobj.data("filename") + "'>"
				+ "<input type='hidden' name='attachList[0].uuid' value='" + jobj.data("uuid") + "'>"
				+ "<input type='hidden' name='attachList[0].uploadPath' value='" + jobj.data("path") + "'>";
		});
		
		$("#detailResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			str2 += "<input type='hidden' name='attachList[1].fileName' value='" + jobj.data("filename") + "'>"
				+ "<input type='hidden' name='attachList[1].uuid' value='" + jobj.data("uuid") + "'>"
				+ "<input type='hidden' name='attachList[1].uploadPath' value='" + jobj.data("path") + "'>";
		});
		
		formObj.append(str1+str2).submit();
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|xlsx|pptx|txt|html)$");
	var maxSize = 5242880;
	
	//첨부 파일 확장자 및 크기 확인 함수
	function checkExtension(fileName, fileSize){
		//파일 크기가 maxSize를 초과하는 경우
		if(fileSize > maxSize){
			alert('업로드 파일 사이즈가 초과하였습니다.');
			return false;
		}
		
		//파일 확장자가 ex, sh, zip, alz인 경우
		if(regex.test(fileName)){
			alert('업로드 할 수 없는 파일입니다.');
			return false;
		}
		
		return true;
	}	//END checkExtention()
	
	//업로드 영역 복제
	//<input type='file'>의 경우에는 readonly이기 때문에 안쪽의 내용을 수정할 수 없기 때문에 clone() 방법을 씀
	var uploadDivClone = $('#thumb').clone();	//선택된 파일이 없습니다.	부분
	var uploadDivClone2 = $('#detail').clone();	//선택된 파일이 없습니다.	부분
	
	//첨부 파일 클릭 이벤트 처리
	//별도의 업로드 버튼 없이
	//<input type='file'>의 내용이 변경되는 것을 감지해서 처리
	
	//CSRF 토큰 관련 변수 추가
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$("#uploadThumb").change(function(e){
		var formData = new FormData();
		var inputFile = $("#uploadThumb");	//input태그 중 name이 uploadFile인 것 찾기
		var files = inputFile[0].files;
		
		
		//add filedate to formdata
		for(f of files){
//			alert("file name : " + f.name + "\nfile size: " + f.size);
			if(!checkExtension(f.name, f.size)){
				return false;
			}
			formData.append("uploadFile", f);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend: function(xhr){//전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result){
				alert('임시업로드 성공');
				console.log(result);
				
				$('#thumb').html(uploadDivClone.html());	//복제해 둔 내용으로 초기화

				//업로드 결과 처리 함수
				showUploadedResult(result);
			},
			error: function(error){
				alert('임시업로드 실패');
			}
		});	//END $.ajax
		
	});	//END $("#uploadBtn").click
	
	//업로드된 결과를 화면에 섬네일 등을 만들어서 처리
	function showUploadedResult(result){
		if(!result || result.length == 0){return;}
		
		var li = "";
		
		$(result).each(function(index, aFileDTO){	//jquery에서는 for문 대신 each 쓸 수 있음
//			$('.uploadResult ul').append('<li>' + aFileDTO.fileName + '</li>');
			//이미지가 아니면 attach.png 표시
			//클릭하면 다운로드
			if(aFileDTO.image == false){
				var filePath = encodeURIComponent(aFileDTO.uploadPath + "/" + aFileDTO.uuid + "_" + aFileDTO.fileName);
				var fileLink = filePath.replace(new RegExp(/\\/g), "/");
				
				li += "<li data-path='" + aFileDTO.uploadPath + "'"
					+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
					+ "' data-type='" + aFileDTO.image + "'><div>"
					+ "<span>" + aFileDTO.fileName + "</span>"
					+ "<button type='button' data-file=\'" + filePath + "\' data-type = 'file'"
					+ "class='btn btn-warning btn-circle'><i class = 'fa fa-times'></i></button><br>"	//i태그: 동그란 X 스타일
					//+ "<img src='/resources/img/attach.png'>"
					+ "<img src='/display?fileName=" + filePath + "'>"
					+ "</div></li>";
				
			}else{	
				var filePath = encodeURIComponent(aFileDTO.uploadPath + "/s_" + aFileDTO.uuid + "_" + aFileDTO.fileName);

				li += "<li data-path='" + aFileDTO.uploadPath + "'"
					+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
					+ "' data-type='" + aFileDTO.image + "'><div>"
					+ "<span>" + aFileDTO.fileName + "</span>"
					+ "<button type='button' data-file=\'" + filePath + "\' data-type = 'image'"
					+ "class='btn btn-warning btn-circle'><i class = 'fa fa-times'></i></button><br>"
					+ "<img src='/display?fileName=" + filePath + "'>"
					+ "</div></li>";
				
				//섬네일 클릭 시 showImage() 호출
//				var originPath = aFileDTO.uploadPath + "\\" + aFileDTO.uuid + "_" + aFileDTO.fileName;
//				originPath = originPath.replace(new RegExp(/\\/g), "/");	//역슬래시를 슬래시로 바꾸는 처리
			}
		});
		$("#thumbResult ul").append(li);
	}
//////////////////////////////////////////////////////////////////	
	
	$("#uploadDetail").change(function(e){
		var formData = new FormData();
		var inputFile = $("#uploadDetail");	//input태그 중 name이 uploadFile인 것 찾기
		var files = inputFile[0].files;
		
		console.log(files);
		
		//add filedate to formdata
		for(f of files){
//			alert("file name : " + f.name + "\nfile size: " + f.size);
			if(!checkExtension(f.name, f.size)){
				return false;
			}
			formData.append("uploadFile", f);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend: function(xhr){//전송 전 추가 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result){
				alert('임시업로드 성공');
				console.log(result);
				
				$('#detail').html(uploadDivClone2.html());	//복제해 둔 내용으로 초기화

				//업로드 결과 처리 함수
				showUploadedResult2(result);
			},
			error: function(error){
				alert('임시업로드 실패');
			}
		});	//END $.ajax
		
	});	//END $("#uploadBtn").click
	
	//업로드된 결과를 화면에 섬네일 등을 만들어서 처리
	function showUploadedResult2(result){
		if(!result || result.length == 0){return;}
		
		var li = "";
		
		$(result).each(function(index, aFileDTO){	//jquery에서는 for문 대신 each 쓸 수 있음
//			$('.uploadResult ul').append('<li>' + aFileDTO.fileName + '</li>');
			//이미지가 아니면 attach.png 표시
			//클릭하면 다운로드
			if(aFileDTO.image == false){
				var filePath = encodeURIComponent(aFileDTO.uploadPath + "/" + aFileDTO.uuid + "_" + aFileDTO.fileName);
				var fileLink = filePath.replace(new RegExp(/\\/g), "/");
				
				li += "<li data-path='" + aFileDTO.uploadPath + "'"
					+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
					+ "' data-type='" + aFileDTO.image + "'><div>"
					+ "<span>" + aFileDTO.fileName + "</span>"
					+ "<button type='button' data-file=\'" + filePath + "\' data-type = 'file'"
					+ "class='btn btn-warning btn-circle'><i class = 'fa fa-times'></i></button><br>"	//i태그: 동그란 X 스타일
					//+ "<img src='/resources/img/attach.png'>"
					+ "<img src='/display?fileName=" + filePath + "'>"
					+ "</div></li>";
				
			}else{	
				var filePath = encodeURIComponent(aFileDTO.uploadPath + "/s_" + aFileDTO.uuid + "_" + aFileDTO.fileName);

				li += "<li data-path='" + aFileDTO.uploadPath + "'"
					+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
					+ "' data-type='" + aFileDTO.image + "'><div>"
					+ "<span>" + aFileDTO.fileName + "</span>"
					+ "<button type='button' data-file=\'" + filePath + "\' data-type = 'image'"
					+ "class='btn btn-warning btn-circle'><i class = 'fa fa-times'></i></button><br>"
					+ "<img src='/display?fileName=" + filePath + "'>"
					+ "</div></li>";
				
				//섬네일 클릭 시 showImage() 호출
//				var originPath = aFileDTO.uploadPath + "\\" + aFileDTO.uuid + "_" + aFileDTO.fileName;
//				originPath = originPath.replace(new RegExp(/\\/g), "/");	//역슬래시를 슬래시로 바꾸는 처리
			}
		});
		$("#detailResult ul").append(li);
	}	
	
	
	
///////////////////////////////////////////////////////////////////	
	//X 표시 클릭 이벤트 처리
	$("#thumbResult").on("click", "button", function(e){
//		alert("x 눌렀다!");
		var targetFile = $(this).data('file');
		
		var targetLi = $(this).closest("li");
		
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
		
	});
	

//X 표시 클릭 이벤트 처리
$("#detailResult").on("click", "button", function(e){
//	alert("x 눌렀다!");
	var targetFile = $(this).data('file');
	
	var targetLi = $(this).closest("li");
	
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
	
});


//이벤트 시작일 체크
$("#inputEventStart").change(function() {
	var startString = $("#inputEventStart").val();
	var now = new Date();
    var yyyy = startString.substr(0,4);
    var mm = startString.substr(5,2);
    var dd = startString.substr(8,2);                        
    var startDate = new Date(yyyy, mm-1, dd);

	if(startDate <= now) {
		alert("오늘 이후부터 선택하실 수 있습니다");
		$("#inputEventStart").val("");
	}
	
});


//이벤트 종료일 체크
$("#inputEventEnd").change(function() {
	var endString = $("#inputEventEnd").val();
	var startString = $("#inputEventStart").val();
    
    
    
    if(endString < startString) {
    	alert("시작일보다 이전 날짜는 선택하실 수 없습니다");
    	$("#inputEventEnd").val("");
    }
    
    if(startString === "") {
    	alert("시작일을 먼저 선택해주세요");
    	$("#inputEventEnd").val("");
    }
	
	
});





$("#eventRegister").click(function() {
	
	var titleChk = document.getElementById("inputTitle").value;
	var eventStartChk = document.getElementById("inputEventStart").value;
	var eventEndChk = document.getElementById("inputEventEnd").value;
	var thumbImgChk = document.getElementById("uploadThumb").value;
	var detailImgChk = document.getElementById("uploadDetail").value;

			if(titleChk!="" && eventStartChk!="" && eventEndChk!="" && thumbImgChk!="" && detailImgChk!=""){
				alert("이벤트 게시글이 등록되었습니다");
				document.frm.submit();
			} else if(titleChk == null || titleChk === ""){
				alert("제목을 입력해주세요");
				document.frm.title.focus();
			} else if(eventStartChk == null || eventStartChk === ""){
				alert("이벤트 시작일을 입력해주세요");
				document.frm.eventStart.focus();
			} else if(eventEndChk == null || eventEndChk === ""){
				alert("이벤트 종료일을 입력해주세요");
				document.frm.eventEnd.focus();
			} else if(thumbImgChk == null || thumbImgChk === ""){
				alert("썸네일용 이미지를 선택해주세요");
				$("#uploadThumb").focus();
			} else if(detailImgChk == null || detailImgChk === ""){
				alert("상세정보용 이미지를 선택해주세요");
				$("#uploadDetail").focus();
			}
});



});	//END $
</script>
 

<%@ include file="../includes/footer.jsp" %>