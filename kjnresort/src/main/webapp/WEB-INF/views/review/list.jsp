<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
    	<br><br><br><br>s
        <h2 class="page-header">후기 게시판</h2>
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
             <!-- 검색 조건 및 키워드 입력 부분 -->
                <div class="row">
                	<div class="col-lg-12">
                		<form id="searchForm" action="/review/list">
                		<button class="btn btn-default pull-right" id="searchBtn">Search</button>
                		<input type="text" name="keyword" id="keyword" class="pull-right" value="${pageMaker.cri.keyword}">
                			<select name='type' id="type" class="pull-right">
                				<c:set var="type" value="${pageMaker.cri.type}"/>
                				<option value="">검색 조건 지정</option>
                				<option value="T" 
                						<c:out value="${type == 'T'?'selected':''}"/>
                				>스키</option>
                				<option value="C"
                						<c:out value="${type == 'C'?'selected':''}"/>
                				>콘도</option>
                				<option value="W"
                						<c:out value="${type == 'W'?'selected':''}"/>
                				>기타</option>
                			</select>
  		                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		                	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                			
                		</form>
                	</div>
                </div>
                <!-- END 검색 조건 및 키워드 입력 부분 -->
                <table class="table table-striped table-bordered table-hover">	   
                    <thead>
                        <tr>
                            <th>NO.</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>ID</th>
                            <th>작성일자</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list }" var="review">
                        <tr class="odd gradeX">
                            <td>${review.reviewNo }</td>
                            <td>${review.category }</td>
                            <td><a class="move" href="${review.reviewNo}">
                            		${review.title }
                            	</a></td>
                            <td>${review.id }</td>
                            <td><fmt:formatDate value="${review.regdate}"
                            					pattern="yyyy-MM-dd"/></td>
                            <td>${review.viewCnt}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                          
                <!-- 페이지 번호 출력 -->
                <div class="pull-right">
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
                <form action="/review/list" id="actionForm">
                	<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}">
                	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                	<!-- 검색 조건과 키워드 파라미터 추가 -->
                	<input type="hidden" name="type" value="${pageMaker.cri.type}">
                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>
<!--                 
                Modal
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
               		 aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                                처리가 완료되었습니다.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Save changes</button>
                            </div>
                        </div>/.modal-content
                    </div>    /.modal-dialog
                </div>        /.modal
            </div>
            /.panel-body
        </div>
        /.panel
    </div>
    /.col-lg-6
</div>
/.row
 -->
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
	$('.move').click(function(e){
		e.preventDefault();
		
		$('#actionForm').append("<input type='hidden' name='reviewNo' value='" +
						         $(this).attr('href') + "'>")
						.attr('action', '/review/get')
						.submit();
	});
	
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











