<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<style>
h2{text-align: center;}
hr{text-align: center; width:1000px;}
footer{margin-top:400px !important;}
button { margin-right: 5px;}

.info_div{ align-self: center;  width:1000px; margin:0 auto; margin-top:30px; background: #EAEAEA; padding:40px;}
.buttons{text-align: right; margin-top:30px;}
.reserveInfoUl{list-style: none; }
.reserveInfoUl>li{margin-left:150px; font-size: 26px; margin-bottom:25px;}
.reserveInfoUl>li>span{font-size: 28px; font-weight:bold;  margin-right: 15px;}
.buttons{text-align: right; margin-top:30px;}
</style>
<br><br><br><br>
<h2>
	이용권 구매내역
</h2>
<hr>

<div class="info_div">
    
	<ul class="reserveInfoUl">           
       <li><span>구매번호</span>${ticket.ticketNo }</li>
       <li><span>구매일시</span>${ticket.buyDate }</li>
	   <li><span>상태</span>
	   	   <c:choose>
			<c:when test="${ticket.status == 0}">
				구매
			</c:when>
			<c:when test="${ticket.status == 1}">
				취소
			</c:when>
			<c:when test="${ticket.status == 2}">
				이용
			</c:when>
	       </c:choose>						
	   </li>
          
       <li><span>이름</span>${member.name }</li>
       <li><span>핸드폰 번호</span>${member.phoneNumber }</li>
       
       <li><span>이용 정보</span>리프트(4시간)/${ticket.liftAmount}매, 장비(4시간)/${ticket.toolAmount}매</li>

       <li><span>결제금액</span>${ticket.totalPrice}</li>
       
     </ul>
       <div class="buttons">	    	  
        <c:if test="${ticket.status == 2 && ticket.review == 0}">             
       	<button data-oper='review' class="btn btn-primary pull-right">후기등록</button>
       	</c:if>
       	<c:if test="${ticket.status == 0}">
       	<button data-oper='cancel' name="cancel" class="btn btn-danger pull-right">구매 취소</button>
       	</c:if>
       	<button data-oper='list' class="btn btn-secondary pull-right">목록</button>
       </div>	
        <form method="post" action="/ticket/cancel" id="operForm">
        	<input type="hidden" id="ticketNo" name="ticketNo" value="${ticket.ticketNo}">
        	<input type="hidden" id="ticketId" name="id" value="${ticket.id}">
        	<input type="hidden" name="pageNum" value="${cri.pageNum}">
        	<input type="hidden" name="amount" value="${cri.amount}">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        	<!-- 키워드 파라미터 추가 -->
        	<input type="hidden" name="type" value="${cri.type}">
        	<input type="hidden" name="keyword" value="${cri.keyword}">
        </form>
           
 </div>

<script>
$(function(){
	var frm = $('#operForm');
	
	$("button[data-oper='review']").click(function(e){
		frm.attr("method", "get");
		frm.attr("action", "/review/register").submit();
	});
	
	$("button[data-oper='list']").click(function(e){
		frm.attr("method", "get");
		frm.attr("action", "/ticket/buyTicketListUser").submit();
	});
	
	$("button[data-oper='cancel']").click(function(e){
		var answer;
		answer = confirm("구매 취소 하시겠습니까?");
		if (answer == true) {
			frm.attr("action", "/ticket/cancel").submit();
		} else {
			e.preventDefault();
		}
	}); 
 
});
</script>

<script src="/resources/js/reply.js"></script>
<script>
//즉시 실행함수 
(function(){
	
	
})(); //END 즉시 실행함수 

$(function(){
	var boardNo = '${board.bno}';
	var replyUL = $('.chat');
	
	
	
	//모달 창 관련 처리--------------------------------------
	var modal = $('.modal');
	var modalInputReply = $('#reply');
	var modalInputReplyer = $('#replyer');
	var modalInputReplyDate = $('#replyDate');
	
	var modalModBtn = $('#modalModBtn');
	var modalRemoveBtn = $('#modalRemoveBtn');
	var modalRegisterBtn = $('#modalRegisterBtn');
	
	var replyer = null;  //로그인한 아이디
    <sec:authorize access="isAuthenticated()">
        replyer = '<sec:authentication property="principal.username"/>';
    </sec:authorize>
    
	var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수 추가
	var csrfTokenValue = '${_csrf.token}';
	
	//beforeSend 대신 사용 - 
	$(document).ajaxSend(function(e, xhr, options){ //전송 전 추가 헤더 설정
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//댓글 삭제 버튼 이벤트 처리
	modalRemoveBtn.click(function(){
		if(replyer == null) { //로그인하지 않은 경우 삭제 불가
			alert('로그인 후 삭제 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		//자신이 작성한 댓글이 아닌 경우 삭제 불가
		if(replyer != modalInputReplyer.val()){
			alert('자신이 작성한 댓글만 삭제 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		//댓글 삭제
		replyService.remove(
			modal.data('rno'),
			modalInputReplyer.val(), //댓글 작성자 전송 추가
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
		if(replyer == null) { 					//로그인하지 않은 경우 수정 불가
			alert('로그인 후 수정 가능합니다!!!');
			modal.modal('hide');
			return;
		}
		
		if(replyer != modalInputReplyer.val()){	//자신이 작성한 댓글이 아닌 경우 수정 불가
			alert('자신이 작성한 댓글만 수정 가능합니다!!!');
			modal.modal('hide');
			return;
		}
 
		replyService.update(					//댓글 수정
			{ rno:modal.data('rno'), 
			  reply:modalInputReply.val(),
			  replyer:modalInputReplyer.val() }, //댓글 작성자 전송 추가
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
	$('#addReplyBtn').click(function(){
		modal.find('input').val('');
		modal.find("input[name='replyer']").val(replyer); //replyer를 폼에 추가
		modalInputReplyDate.closest('div').hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		modal.modal('show');
	}); //END New Reply 버튼 이벤트 처리
	
	console.log(replyService);
});
</script>
<%@ include file="../includes/footer.jsp" %>


























