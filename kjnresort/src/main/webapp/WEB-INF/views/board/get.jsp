<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<%@ include file="../includes/header.jsp" %>
<style>
	.uploadResult			{width:100%; 						background-color:lightblue;}
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
        <h1 class="page-header">
        	<!-- Tables -->
        	Board Read Page	
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
                <!-- Board Register -->
                Board Read Page	
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
	            <div class="form-group">
	                <label>Bno</label>
	                <input class="form-control" name="bno"
	                	   value="${board.bno }" readonly></div>
	            <div class="form-group">
	                <label>Title</label>
	                <input class="form-control" name="title"
	                	   value="${board.title }" readonly></div>
	            <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content"
	                	      readonly>${board.content }</textarea></div>
	            <div class="form-group">
	                <label>Writer</label>
	                <input class="form-control" name="writer"
	                	   value="${board.writer }" readonly></div>
	             <!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->
	             <sec:authentication property="principal" var="pinfo"/>
	             	<sec:authorize access="isAuthenticated()">
	             		<c:if test="${pinfo.username eq board.writer }">
	           			 	<button data-oper='modify' class="btn btn-default"> Modify</button>
	           			 </c:if>
	            	</sec:authorize>
                <button data-oper='list' class="btn btn-info"> List</button>
                <form action="/board/modify" id="operForm">
                	<input type="hidden" id="bno" name="bno" value="${board.bno }">
                	<input type="hidden" name="pageNum" value="${cri.pageNum}">
                	<input type="hidden" name="amount" value="${cri.amount}">
                	<!-- 검색 조건과 키워드 파라미터 추가 -->
                	<input type="hidden" name="type" value="${cri.type}">
                	<input type="hidden" name="keyword" value="${cri.keyword}">
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
			<!-- 	<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
				</div> -->
				<div class="uploadResult">
					<ul>

					</ul>
				</div>
			</div>
		</div>
	</div>
</div>						<!-- END 첨부 파일 -->
 
  
<!-- 댓글 목록 -->
<div class='row'>
  <div class='col-lg-12'>
 	<div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> Reply
            <!-- 로그인한 사용자만 댓글 작성 버튼 처리 -->
            <sec:authorize access="isAuthenticated()">
	            <button type="button" class="btn btn-primary pull-right btn-xs"
	            		id="addReplyBtn">
	            	New Reply</button>
            </sec:authorize>
        </div>
        <div class="panel-body">
           <ul class="chat">
           	  <!-- START reply list -->
              <li class="left clearfix" data-rno='12'>
              	<div>
                   <div class="header">
                       <strong class="primary-font"></strong>
                       <small class="pull-right text-muted">
                           
                       </small>
                   </div>
                   <p></p>
                 </div>
              </li>
           	  <!-- END reply list -->
            </ul>
          </div>	<!-- /.panel-body -->
          
          <!-- 댓글 목록 페이징 -->
          <div class="panel-footer">
          
          </div>
          <!-- END 댓글 목록 페이징 -->
     </div>			<!-- /.panel -->
  </div>			<!-- /.col-lg-12 -->
</div>				<!-- /.row -->
<!-- END 댓글 목록 -->

<!-- 댓글 모달 창 -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" 
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" 
	                	 	data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">
	                	REPLY MODAL</h4>
	            </div>
	            <div class="modal-body">
	                <div class="form-group">
	                	<label>Reply</label>
			            <input class="form-control" id="reply"
			            	   name="reply" value="New Reply!!"></div>
	                <div class="form-group">
	                	<label>Replyer</label>
	                	<input class="form-control" id="replyer" readonly
			            	   name="replyer" value="replyer"></div>
	                <div class="form-group">
	                	<label>Reply Date</label>
	                	<input class="form-control" id="replyDate"
			            	   name="replyDate" value=""></div>
	            </div>
	            <div class="modal-footer">
	                <button id="modalModBtn" class="btn btn-warning">Modify</button>
	                <button id="modalRemoveBtn" class="btn btn-danger">Remove</button>
	                <button id="modalRegisterBtn" class="btn btn-primary">Register</button>
	                <button id="modalCloseBtn" class="btn btn-default" 
	                		data-dismiss="modal">Close</button>
	            </div>
	        </div>	<!-- /.modal-content -->
	    </div>		<!-- /.modal-dialog -->
	</div>			<!-- /.modal -->
<!-- END 댓글 모달 창 -->


<script>
$(function(){
	var frm = $('#operForm');
	
	$("button[data-oper='modify']").click(function(e){
		frm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='list']").click(function(e){
		frm.find("#bno").remove();
		frm.attr("action", "/board/list").submit();
	});
});
</script>

<script src="/resources/js/reply.js"></script>
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
						str += "<span> " + obj.fileName + "</span><br>";
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

//	첨부파일 클릭시 이벤트 처리
$(".uploadResult").on("click","li",function(e){
	console.log("view image");
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
	
	if(liObj.data("type")) {									//	이미지 파일인 경우
		showImage(path.replace(new RegExp(/\\/g),"/"));
	} else {													//	이미지 파일이 아닌 경우
		//download
		self.location = "/download?fileName=" + path
	}
});

	function showImage(filePath){
		// alert(filePath);
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture").html("<img src='/display?fileName=" + filePath +"'>")
						.animate({width:'100%', height:'100%'}, 1000); 
		}
		$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height:'0%'},1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		},1000);
	});

$(function(){
	var boardNo = '${board.bno}';
	var replyUL = $('.chat');
	
	//댓글 목록 출력 함수 호출 - page 번호는 1로 지정
	showList(1);
	
	//댓글 목록 <li> 구성
	function showList(page){
		replyService.getList(	//댓글 목록
			{ bno:boardNo, page:page || 1 },	//page 번호가 없을 경우 1로 설정
//			function(result){ 
			function(replyCnt, list){ 
				//page 번호가 -1인 경우 - 마지막 페이지 표시
				if(page == -1){
					showList(Math.ceil(replyCnt/10.0));
					return;
				}
				
				if(list == 0 || list == null) { //댓글 목록이 없으면
					//replyUL의 내용을 비우고 중단
					replyUL.html('');
					return;
				}

				var li = '';
				for (rvo of list) {
					//댓글 목록을 replyUL에 <li>로 추가
					li += "<li class='left clearfix' data-rno='" + rvo.rno + "'>" +
						  "  <div><div class='header'>" +
						  "         <strong class='primary-font'>" + rvo.replyer + "</strong>" +
						  "         <small class='pull-right text-muted'>" + 
						  				replyService.displayTime(rvo.replyDate) +  																
						  "         </small></div>" +
						  "		 <p>" + rvo.reply + "</p></div></li>"
				}  
				replyUL.html(li);
				showReplyPage(replyCnt);
			}
		);//END replyService.getList()
	}//END showList()
	
	//댓글 목록 페이징 ----------------------------------
	var pageNum = 1;
	var replyPageFooter = $('.panel-footer');
	
	function showReplyPage(replyCnt){	//PageDTO.java + list.jsp 
		var endPage		= Math.ceil(pageNum / 10.0) * 10;
		var startPage	= endPage - 9;
		var prev		= startPage != 1;
		var next		= false;
		
		if(endPage * 10 >= replyCnt){
			endPage = Math.ceil(replyCnt/10.0);
		}
		
		if(endPage * 10 < replyCnt){
			next = true;
		}
		
		var ul = "<ul class='pagination pull-right'>";
		if(prev) {	 
			ul += "<li class='paginate_button previous'>" +
				  "    <a href='" + (startPage - 1) + "'>Previous</a></li>";
		}
		
		for(var num = startPage ; num <= endPage ; num++){
			var active = pageNum == num ? 'active' : '';
			ul += "<li class='paginate_button " + active + "''>" +
				  "    <a href='" + num + "'>" + num + "</a></li>";
		}

		if(next) {
			ul += "<li class='paginate_button next'>" +
			  "    <a href='" + (endPage + 1) + "'>Next</a></li>";
		}

		ul += "</ul>";
		replyPageFooter.html(ul);
	}//END showReplyPage()
	
	//댓글 페이지 번호 클릭 이벤트 처리
	replyPageFooter.on('click', 'li a', function(e){
		e.preventDefault();
		pageNum = $(this).attr('href');
		showList($(this).attr('href'));
	});	//END 댓글 페이지 번호 클릭 이벤트 처리
	//END 댓글 목록 페이징 ----------------------------------
	
	
	//모달 창 관련 처리--------------------------------------
	var modal = $('.modal');
	var modalInputReply = $('#reply');
	var modalInputReplyer = $('#replyer');			// 댓글 작성자
	var modalInputReplyDate = $('#replyDate');
	
	var modalModBtn = $('#modalModBtn');
	var modalRemoveBtn = $('#modalRemoveBtn');
	var modalRegisterBtn = $('#modalRegisterBtn');
	
	var replyer = null;								// 로그인한 아이디
	
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	//CSRF 토큰 관련 변수 추가
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	// BeforeSend 대신 사용 -
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//댓글 삭제 버튼 이벤트 처리
	modalRemoveBtn.on('click',function(e){
		if(replyer == null) {								// 로그인하지 않은 경우 삭제 불가
			alert("로그인후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}	
		var originalReplyer = modalInputReplyer.val();
		if(replyer != originalReplyer) {					// 자신이 작성한 댓글이 아닐 경우 삭제 불가
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		replyService.remove(								//댓글 삭제
			modal.data('rno'),
			originalReplyer,
			function(result){
				alert(result);
				modal.modal('hide');
// 				showList(1);
				showList(pageNum);
			},
			function(err){
				console.log('reply remove error');
			}
		);
	});//END 댓글 삭제 버튼 이벤트 처리
	
	//댓글 수정 버튼 이벤트 처리
	modalModBtn.on('click',function(){
		if(replyer == null) {								// 로그인하지 않은 경우 삭제 불가
			alert("로그인후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}	
		var originalReplyer = modalInputReplyer.val();
		if(replyer != originalReplyer) {					// 자신이 작성한 댓글이 아닐 경우 삭제 불가
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		//댓글 수정
		replyService.update(
			{ rno:modal.data('rno'), 
			  reply:modalInputReply.val(),
			  replyer: originalReplyer},
			function(result){
				alert(result);
				modal.modal('hide');
// 				showList(1);
				showList(pageNum);
			},
			function(err){
				console.log('reply update error');
			}
		);//END replyService.update()
	});//END 댓글 수정 버튼 이벤트 처리
	
	//댓글 클릭 이벤트 처리
	replyUL.on('click', 'li', function(e){
		//댓글 조회
		replyService.get(
			$(this).data('rno'),
			function(result){
				modalInputReply.val(result.reply);
				modalInputReplyer.val(result.replyer);
				modalInputReplyDate.val(replyService.displayTime(result.replyDate))
								   .attr('readonly', 'readonly');
				
				modal.data('rno', result.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				modal.modal('show');
			},
			function(err){
				console.log('reply get error');
			}
		);//END replyService.get()
	});	//END 댓글 클릭 이벤트 처리
		
	//Register 버튼 이벤트 처리
	modalRegisterBtn.click(function(){
		//댓글 추가
		replyService.add(
			{ bno:boardNo, 
			  reply : modalInputReply.val(), 	 //'댓글 테스트',
			  replyer: modalInputReplyer.val() },//'tester'
			function(result){
					alert(result);
				modal.find('input').val('');
				modal.modal('hide');
// 				showList(1);
				showList(-1);
			}
		);//END replyService.add()
	}); //END Register 버튼 이벤트 처리

	
	//New Reply 버튼 이벤트 처리
	$('#addReplyBtn').on("click", function(e){
		modal.find('input').val('');
		//replyer를 폼에 추가
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest('div').hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		modal.modal('show');
	}); //END New Reply 버튼 이벤트 처리
	
	console.log(replyService);
});
</script>
<%@ include file="../includes/footer.jsp" %>


