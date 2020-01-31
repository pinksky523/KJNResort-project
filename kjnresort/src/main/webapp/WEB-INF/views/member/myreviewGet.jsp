<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="zxx">
<style>

h2{text-align: center;}
hr{text-align: center; width:1000px;}
button { margin-right: 5px;}
p {color: black;}
#star { height: 20px; width: 100px; }

.info_div{ align-self: center;  width:1300px; margin:0 auto; margin-top:30px; background: #EAEAEA; padding:40px;}

   		  
.uploadResult { width:100%; 				background: white; }
.uploadResult ul { 	display:flex; 			flex-flow:row;
					justify-content: center;align-items: center;}
.uploadResult ul li {	list-style: none;	padding:10px; width:80%;}
.uploadResult ul li img { width:100px; height: 200px; }
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
<head>
	<title>KJN RESORT</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
	<meta charset="UTF-8">
	<meta name="description" content="loans HTML Template">
	<meta name="keywords" content="loans, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
	
	<!-- Favicon -->
	<link href="img/favicon.ico" rel="shortcut icon"/>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
 	
<!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<!--<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">-->	 
	<!-- Main Stylesheets -->
	<link rel="stylesheet" href="/resources/css/style.css"/>

</head>
<br><br><br>
<body class="contents" style="height: 100%;">
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header Section -->
	<header class="header-section">
		<a href="/" class="site-logo">
			<img src="/resources/img/logo.png" alt="">
		</a>
		<nav class="header-nav">
			<ul class="main-menu">
				<li><a href="/common/resortInfo">리조트안내</a></li>
				<li><a href="/notice/list">공지사항</a></li>
				<li><a href="#">콘도</a>
					<ul class="sub-menu">
						<li><a href="about-us.html">콘도 예약</a></li>
						<li><a href="loans.html">콘도 예약내역</a></li>
					</ul>
				</li>
				<li><a href="#">이용권</a>
					<ul class="sub-menu">
						<li><a href="/ticket/buyTicket">이용권 구매</a></li>
						<li><a href="/ticket/buyTicketListUser">이용권 구매내역</a></li>
					</ul>
				</li>
				<li><a href="/event/list">이벤트</a></li>
				<li><a href="/review/list">후기</a></li>
				<li><a href="#">1:1문의</a>
					<ul class="sub-menu">
						<li><a href="/qna/register">문의하기</a></li>
						<li><a href="/qna/list">문의내역</a></li>
					</ul>
				</li>
				<li><a href="#">인재채용</a>
					<ul class="sub-menu">
						<li><a href="/recruit/list">모집공고</a></li>
						<li><a href="/appliance/myList">지원내역조회</a></li>
					</ul>
				</li>
				<li>
				<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="pinfo"/>'>
				
				  <c:if test="${pinfo.username ne 'admin'}">		<!-- 관리자로 로그인할 경우 아무버튼 없음 -->
				  	<form id="mypageForm" action="/member/mypage" method="get">
						<button type="submit" class="btn btn-secondary" id="mypage">마이페이지</button>
					 </form>
 				 </c:if>
				</sec:authorize>
				
				<!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/common/customLogin'" class="btn btn-secondary" id="customLogin">로그인</button>
				</sec:authorize>
				</li>
				
				<li>
				<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				<button type="button" onclick="location.href='/common/customLogout'" class="btn btn-danger" id="customLogout">로그아웃</button>
				</sec:authorize>
				
				<!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/common/memberJoin'" class="btn btn-danger" id="register">회원가입</button>
				</sec:authorize>
				</li>
			
			</ul>
		</nav>
	</header>
	
	<!-- Header Section end -->
	
	<!-- JQuery -->
	<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> -->
	 <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> 

<br><br><br><br><br>
<h2>
     후기 게시판
</h2>
<hr>

<div class="info_div">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <!-- /.panel-heading -->
            <div class="panel-body">
	            <div class="form-group">
	                <label>제목</label>
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
                    <label>평점</label>  <%-- <input class="form-control" name="grade" value="${review.grade }"readonly></div> --%>
                    <c:choose>
                    	<c:when test="${review.grade eq 1}">
							<img id="star" src='../../resources/images/one.PNG'>
						</c:when>
						<c:when test="${review.grade eq 2}">
							<img id="star" src='../../resources/images/two.PNG'>
						</c:when>
						<c:when test="${review.grade eq 3}">
							<img id="star" src='../../resources/images/three.PNG'>
						</c:when>
						<c:when test="${review.grade eq 4}">
							<img id="star" src='../../resources/images/four.PNG'>
						</c:when>
						<c:otherwise>
							<img id="star" src='../../resources/images/five.PNG'>
						</c:otherwise>
                    </c:choose>
	            <div class="form-group">
                    <label>내용</label>
                    <textarea class="form-control" rows="3" name="content"
	                	      readonly>${review.content }</textarea></div>     	          	      

	            <sec:authorize access="isAuthenticated()">
					<button type="button" id="addReplyBtn" class="btn btn-primary pull-right">댓글등록</button>
	            </sec:authorize>
            	<!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->
				<sec:authorize access="isAuthenticated()">
	            	<c:if test="${pinfo.username == review.id }">
			            <button data-oper='modify' name="modify" class="btn btn-warning pull-right">수정</button>
			            <button data-oper='remove' name="remove" class="btn btn-danger pull-right">삭제</button>
	            	</c:if>
            	</sec:authorize>
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

  
<!-- 첨부파일  -->
<div class="row" style="width: 450px;">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">사진</div>
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
	  
<!-- 댓글 목록 -->
<div class='row'>
  <div class='col-lg-12'>
 	<div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> 댓글
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
	<div class="modal fade in" id="myModal" tabindex="-1"   
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
	                	<label>댓글</label>
			            <input class="form-control" id="reply" 
			            	   name="reply" value="New Reply!!"></div>
	                <div class="form-group">
	                	<label>Id</label>
	                	<input class="form-control" id="id" readonly
			            	   name="id" value="replyer"></div>
	                <div class="form-group">
	                	<label>Reply Date</label>
	                	<input class="form-control" id="replyDate"
			            	   name="replyDate" value="2019-12-02 11:22:33"></div>
	            </div>
	            <div class="modal-footer">
	            <sec:authentication property="principal" var="pinfo"/>
			            <button id="modalModBtn" class="btn btn-warning">수정</button>
	                	<button id="modalRemoveBtn" class="btn btn-danger">삭제</button>
	                
	                <button id="modalRegisterBtn" class="btn btn-primary">등록</button>
	                <button id="modalCloseBtn" class="btn btn-default" 
	                		data-dismiss="modal">취소</button>
	            </div>
	        </div>	<!-- /.modal-content -->
	    </div>		<!-- /.modal-dialog -->
	</div>			<!-- /.modal -->
<!-- END 댓글 모달 창 -->
</div> 

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
		frm.attr("method", "post");
		frm.attr.append('<input type="hidden" name="id" value="${review.id}">')
		frm.attr("action", "/review/myreviewList").submit();
	});
});
</script>

<script src="/resources/js/reply.js"></script>
<script>
//즉시 실행함수 
 (function(){
	//첨부파일 목록 가져오기
	$.getJSON("/review/getAttachList", { reviewNo : ${review.reviewNo} }, function(result){
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
					  "    <img src='/display?fileName=" + filePath + "'></div></li>";   			
			});//END each()
			$('.uploadResult ul').append(li);
	}).fail(function(xhr, status, err){
		console.log(err);
	}); //END 첨부파일 목록 가져오기
})(); //END 즉시 실행함수 


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
				for (var i = 0, len = list.length || 0; i< len; i++) {
				    //댓글 목록을 replyUL에 <li> 로 추가 replyService.displayTime(list[i].replyDate)
				    li += "<li class='left clearfix' data-replyno='"+ list[i].replyNo +"'>" +  //result 에 rvo값을 li에 담아서 for문으로 돌려서 댓글숫자만큼 만듬
			              "	<div> "+
			              "     <div class='header'> "+
			              "         <strong class='primary-font'>"+ list[i].reply +"</strong>"+
			              "         <small class='pull-right text-muted'>"+
			              	          replyService.displayTime(list[i].replyDate) +
			              "         </small>"+
			              "     </div>"+
			              "     <p style='color: black;'>"+ list[i].id +"</p></div></li>"
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
	
	//New Reply 버튼 이벤트 처리
	$('#addReplyBtn').click(function(e){
		modal.find('input').val("");
		modal.find("input[name='id']").val(id); 
		modalInputReplyDate.closest('div').hide();
		modalModBtn.hide();
		modalRemoveBtn.hide();
		modalRegisterBtn.show();
		modal.modal('show');
	}); //END New Reply 버튼 이벤트 처리
	
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
		console.log('reply update .........');
		replyService.update(					//댓글 수정
			{ replyNo:modal.data('replyNo'), 
			  reply:modalInputReply.val(),
			  Id:modalInputId.val() }, //댓글 작성자 전송 추가
			function(result){
				  console.log('reply update success.........');
				alert(result);
				modal.modal('hide');
// 				showList(1);
				showList(pageNum);
			},
			function(err){
				console.log('reply update error.........');
			}
		);//END replyService.update()
	});//END 댓글 수정 버튼 이벤트 처리
	
	//댓글 클릭 이벤트 처리
	replyUL.on('click', 'li', function(e){
		//댓글 조회
		replyService.get(
		    $(this).data('replyno'),
			function(result){
				modalInputReply.val(result.reply);
				modalInputId.val(result.id);
				modalInputReplyDate.val(replyService.displayTime(result.replyDate)).attr('readonly', 'readonly');
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

	
	
	
	console.log(replyService);
});
</script>
<%@ include file="../includes/footer.jsp" %>


