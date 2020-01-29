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
button { margin-right: 5px;}
</style>
<div class="row">
    <div class="col-lg-12">
        <h2 class="page-header">
        	후기 게시판1
        </h2>
        <hr>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <!-- /.panel-heading -->
            <div class="panel-body">
	            <div class="form-group">
	                <label>Title</label>
	                <input class="form-control" name="title"
	                	   value="${review.title }" readonly></div>
	            <div class="form-group">
	                <label>카테고리</label>
	                <input class="form-control" name="category"
	                	   value="${review.category }" readonly></div>
	            <div class="form-group">
	                <label>작성자</label>
	                <input class="form-control" name="id"
	                	   value="${review.id }" readonly></div>
				<div class="form-group">
	                <label>조회수</label>
	                <input class="form-control" name="veiwCnt"
	                	   value="${review.viewCnt }" readonly></div>    	   	                	   	                	   
	            <div class="form-group">
                    <label>작성일시</label>
                    <textarea class="form-control" rows="1" name="regdate"
	                	      readonly><fmt:formatDate value="${review.regdate}"
                            					pattern="yyyy-MM-dd"/></textarea></div>
	            <div class="form-group">
                    <label>평점</label>
                    <input class="form-control" name="grade" value="${review.grade }"
	                	      readonly></div>
	            <div class="form-group">
                    <label>내용</label>
                    <textarea class="form-control" rows="3" name="content"
	                	      readonly>${review.content }</textarea></div>     	          	      

	            
               	<button data-oper='reply' name="reply" class="btn btn-primary pull-right">댓글등록</button>
            	<!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->
	            <sec:authentication property="principal" var="pinfo"/>
	            <sec:authorize access="isAuthenticated()">
	            	<c:if test="${pinfo.username == review.id }">
			            <button data-oper='modify' name="modify" class="btn btn-warning pull-right">수정</button>
	            	</c:if>
	            </sec:authorize> 
               	<button data-oper='remove' name="remove" class="btn btn-danger pull-right">삭제</button>
               	<button data-oper='list' class="btn btn-secondary pull-right">목록</button>

	            
         
                <form action="/review/modify" id="operForm">
                	<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo }">
                	<input type="hidden" name="pageNum" value="${cri.pageNum}">
                	<input type="hidden" name="amount" value="${cri.amount}">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                	<!-- 검색 조건과 키워드 파라미터 추가 -->
                	<input type="hidden" name="type" value="${cri.type}">
                	<input type="hidden" name="keyword" value="${cri.keyword}">
                </form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->

<%--  
<!-- 첨부파일  -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">File Attch</div>
            <div class="panel-body">
<!-- 	            <div class="form-group uploadDiv"> -->
<!-- 					<input type="file" name="uploadFile" multiple="multiple"> -->
<!-- 				</div> -->
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
--%>	  
<!-- 댓글 목록 -->
<div class='row'>
  <div class='col-lg-12'>
 	<div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> Reply
            
             <!-- 로그인한 사용자만 댓글 작성 버튼 표시 -->
	         <sec:authorize access="isAuthenticated()">
            	<button type="button" class="btn btn-primary pull-right btn-xs"
            		id="addReplyBtn">
            	New Reply</button>
	         </sec:authorize>
        </div>
        <div class="panel-body">
           <ul class="chat">
           	  <!-- START reply list -->
              <li class="left clearfix" data-replyNo='12'>
              	<div>
                   <div class="header">
                       <strong class="primary-font">user00</strong>
                       <small class="pull-right text-muted">
                           2019-11-29 15:41
                       </small>
                   </div>
                   <p>Good job!</p>
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
	                	<label>Id</label>
	                	<input class="form-control" id="id" readonly
			            	   name="id" value="id"></div>
	                <div class="form-group">
	                	<label>Reply Date</label>
	                	<input class="form-control" id="replyDate"
			            	   name="replyDate" value="2019-12-02 11:22:33"></div>
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
	
	$("button[data-oper='remove']").click(function(e){
		var answer;
		answer = confirm("삭제 하시겠습니까?");
		if (answer == true) {
			frm.attr("method", "post");
			frm.attr("action", "/review/remove").submit();
		} else {
			e.preventDefault();
		}
		
	});
	
	$("button[data-oper='modify']").click(function(e){
			frm.attr("action", "/review/modify").submit();	
	});
	
	$("button[data-oper='list']").click(function(e){
		frm.attr("action", "/member/myreview").submit();
	});
});
</script>

<script src="/resources/js/reply.js"></script>
<script>
//즉시 실행함수 
/* (function(){
	
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
				      "    <div><span>" + obj.fileName + "</span><br>" +
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
					  "    <img src='/display?fileName=" + filePath + "'></div></li>";   			}
			});//END each()
			$('.uploadResult ul').append(li);
	}).fail(function(xhr, status, err){
		console.log(err);
	}); //END 첨부파일 목록 가져오기
})(); //END 즉시 실행함수 
 */
//첨부 파일 클릭 이벤트 처리
$('.uploadResult').on('click', 'li', function(){
	var li = $(this);
	var filePath = encodeURIComponent(li.data('path') + "/" + 
									  li.data('uuid') + "_" +
									  li.data('filename'));
	
	if(li.data('type') == true){//이미지일 때
		showImage(filePath.replace(new RegExp(/\\/g), "/"));
	} else {//일반 파일일 때
		self.location = '/download?fileName=' + filePath;
	}
		
});//END 첨부 파일 클릭 이벤트 처리


//원본 이미지 클릭 이벤트 처리
$('.bigPcitureWrapper').on('click', function(){
	$('.bigPicture').animate({width:'0%', height:'0%'}, 1000);
	setTimeout(() => {
		$(this).hide();
	}, 1000);
}); //END 원본 이미지 클릭 이벤트 처리


//섬네일 이미지 원본 표시
function showImage(filePath){
	$('.bigPcitureWrapper').css('display', 'flex').show();
	$('.bigPicture').html("<img src='/display?fileName=" +
							filePath + "'>")
					.animate({width:'100%', height:'100%'}, 1000);
}// END 섬네일 이미지 원본 표시

$(function(){
	var reviewNo = '${review.reviewNo}';
	var replyUL = $('.chat');
	
	//댓글 목록 출력 함수 호출 - page 번호는 1로 지정
	showList(1);
	
	//댓글 목록 <li> 구성
	function showList(page){
		replyService.getList(	//댓글 목록
			{ reviewNo:reviewNo, page:page || 1 },	//page 번호가 없을 경우 1로 설정
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
					li += "<li class='left clearfix' data-replyNo='" + rvo.replyNo + "'>" +
						  "  <div><div class='header'>" +
						  "         <strong class='primary-font'>" + rvo.id + "</strong>" +
						  "         <small class='pull-right text-muted'>" + 
						  				rvo.replyDate +  																
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
	var modalInputId = $('#id');
	var modalInputReplyDate = $('#replyDate');
	
	var modalModBtn = $('#modalModBtn');
	var modalRemoveBtn = $('#modalRemoveBtn');
	var modalRegisterBtn = $('#modalRegisterBtn');
	
	var id = null;  //로그인한 아이디
    <sec:authorize access="isAuthenticated()">
        id = '<sec:authentication property="principal.username"/>';
    </sec:authorize>
    
	var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수 추가
	var csrfTokenValue = '${_csrf.token}';
	
	//beforeSend 대신 사용 - 
	$(document).ajaxSend(function(e, xhr, options){ //전송 전 추가 헤더 설정
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//댓글 삭제 버튼 이벤트 처리
	modalRemoveBtn.click(function(){
		if(id == null) { //로그인하지 않은 경우 삭제 불가
			alert('로그인 후 삭제 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		//자신이 작성한 댓글이 아닌 경우 삭제 불가
		if(id != modalInputId.val()){
			alert('자신이 작성한 댓글만 삭제 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		//댓글 삭제
		replyService.remove(
			modal.data('replyNo'),
			modalInputId.val(), //댓글 작성자 전송 추가
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
	modalModBtn.click(function(){
		if(id == null) { 					//로그인하지 않은 경우 수정 불가
			alert('로그인 후 수정 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		if(id != modalInputId.val()){	//자신이 작성한 댓글이 아닌 경우 수정 불가
			alert('자신이 작성한 댓글만 수정 가능합니다!!!');
			modal.modal('hide');
			return;
		}
 
		replyService.update(					//댓글 수정
			{ replyNo:modal.data('replyNo'), 
			  reply:modalInputReply.val(),
			  Id:modalInputId.val() }, //댓글 작성자 전송 추가
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
			$(this).data('replyNo'),
			function(result){
				modalInputReply.val(result.reply);
				modalInputId.val(result.id);
				modalInputReplyDate.val(replyService.displayTime(result.replyDate))
								   .attr('readonly', 'readonly');
				
				modal.data('replyNo', result.replyNo);
				
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
			{ reviewNo:reviewNo, 
			  reply : modalInputReply.val(), 	 //'댓글 테스트',
			  id: modalInputId.val() },//'tester'
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
	$('#addReplyBtn').click(function(){
		modal.find('input').val('');
		modal.find("input[name='id']").val(id); //id를 폼에 추가
		modalInputReplyDate.closest('div').hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		modal.modal('show');
	}); //END New Reply 버튼 이벤트 처리
	
	console.log(replyService);
});
</script>
<%@ include file="../includes/footer.jsp" %>


























