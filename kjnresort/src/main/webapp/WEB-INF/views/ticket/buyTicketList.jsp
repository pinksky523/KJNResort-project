<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<%@ include file="../includes/adminHeader.jsp" %>

<style>
h2{text-align: center; position: relative; bottom: 20px;}
hr{text-align: center; width:1000px; color: gray;}

.container{margin-top:40px; height: 400px; margin-bottom:100px; font-size:2rem;}
.table{width:150% !important;text-align:center; } 
.pagination{justify-content: center; }
.text-center{font-size:2rem;}
thead{background: #E7E7E7;}
.pagination{position: relative; }
footer{margin-top:500px !important;}
.reserve_list{width:1000px;}
</style>
    	
<br><br><br><br><br><br><br><br><br>
<h2>이용권 구매내역</h2>
<hr>

<!-- /.row -->
<div class="container">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-body">
                	   
                 <!-- 검색 조건 및 키워드 입력 부분 -->
                <div class="row">
                	<div class="col-lg-12">
                		<form id="searchForm" action="/ticket/buyTicketList">
                			<button class="btn btn-default pull-right" id="searchBtn">Search</button>
                			<select name='type' id="type" class="pull-right">
                				<c:set var="type" value="${pageMaker.cri.type}" />
                				<option value="">검색 조건 지정</option>
                				<option value="T" 
                						<c:out value="${type == 'T'?'selected':''}"/>
                				>아이디</option>
                				<option value="C"
                						<c:out value="${type == 'C'?'selected':''}"/>
                				>구매번호</option>
                			</select>
                			<input type="text" name="keyword" id="keyword" class="pull-right"
                				   value="${pageMaker.cri.keyword}">
                				   
		                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		                	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                			
                		</form>
                	</div>
                </div>
                <!-- END 검색 조건 및 키워드 입력 부분 -->	 
                  
                <table class="table table-hover buy_list">	   
                    <thead>
                        <tr>
                            <th>#구매번호</th>
                            <th>구매일시</th>
                            <th>상태</th>
                            <th>아이디</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach items="${list }" var="ticket">
                        <tr class="odd gradeX">
                            <td>${ticket.ticketNo }</td>
                            <td><a class="move" href="/ticket/buyTicketGet/${ticket.ticketNo}/${ticket.id}">
                            		${ticket.buyDate}
                            	</a></td>
                            <td>
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
                            </td>
                            <td>${ticket.id}</td>
                        </tr>
                    </c:forEach>
                        
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                
                <!-- 페이지 번호 출력 -->
                <div style="text-align: center;">
                	<ul class="pagination">
                		<c:if test="${pageMaker.prev}">
                		<li class="paginate_button previous">
                			<a href="${pageMaker.startPage - 1}">Previous</a></li>
                		</c:if>
                		<c:forEach begin="${pageMaker.startPage}"
                				   end="${pageMaker.endPage}" var="num">
                		<li class="paginate_button
                		   		   ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                			<a href="${num}">${num}</a></li>
                		</c:forEach>
                		<c:if test="${pageMaker.next}">
                		<li class="paginate_button next">
                			<a href="${pageMaker.endPage + 1}">Next</a></li>
                		</c:if>
                	</ul>
                </div>
                <!-- END 페이지 번호 출력 -->
                
                <!-- 페이지 번호 클릭 시 페이지 번호와 출력 데이터 갯수를 전달 -->
                <form action="/ticket/buyTicketList" id="actionForm">
                	<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}">
                	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                	<!-- 검색 조건과 키워드 파라미터 추가 -->
                	<input type="hidden" name="type" value="${pageMaker.cri.type}">
                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>
                
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
               		 aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                <!-- Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. -->
                                                                처리가 완료되었습니다.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Save changes</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div>    <!-- /.modal-dialog -->
                </div>        <!-- /.modal -->
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<script>
$(function(){
	//검색 버튼 이벤트 처리
	$('#searchBtn').click(function(){
		var searchFrm = $('#searchForm');
		
		if(!searchFrm.find('option:selected').val()){	//검색 조건을 지정하지 않은 경우
			alert('검색 종류를 선택하세요');
			return false;
		} else if(!$('#keyword').val()){		//검색어를 입력하지 않은 경우
			alert('키워드를 입력하세요');
			return false;
		}

		//검색 결과 페이지 번호가 1이 되도록 처리
		searchFrm.find("input[name='pageNum']").val("1");
		
	});		
	
	//게시물 조회 링크 처리
/* 	$('.move').click(function(e){
		e.preventDefault();
// 		$('#actionForm').append("<input type='hidden' name='ticketNo' value='" + $(this).attr('href') + "'>" 
// 				                + "<input type='hidden' name='id' value='" + ${ticket.id} + "'>")
		$('#actionForm').append("<input type='hidden' name='id' value='" + ${ticket.id} + "'>")
// 		$('#actionForm').append("<input type='hidden' name='ticketNo' value='" + $(this).attr('href') + "'>" )
						.attr('action', '/ticket/buyTicketGet')
						.submit();
	}); */
	
	//페이지 번호 링크 처리
	$('.paginate_button a').click(function(e){
		e.preventDefault();
		
		$('#pageNum').val($(this).attr('href'));
		$('#actionForm').submit();
	});
	

	//result 값을 저장 - 게시글을 등록/수정/삭제한 경우 
	var result = '${result}';
	
	//result 값이 있는지 확인하는 함수 호출
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	//result 값이 있는지 확인하는 함수
	function checkModal(result){
		if(result === '' || history.state )	return;
		
		if(parseInt(result)>0){
			$('.modal-body').html(result + '번 게시글이 등록되었습니다.');	
		}
		
		$('#myModal').modal('show');
	}
	
	//Register New Board 버튼을 누르면 입력 화면 표시
	$('#regBtn').click(function(){
		self.location = "/board/register";
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>