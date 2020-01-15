<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모집공고</title>
</head>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <!-- DataTables Advanced Tables -->
                Board List Page
                <button id="regBtn" type="button"
          				class="btn btn-xs pull-right">
          			Register New Board		
          		</button>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <!-- <table width="100%" 
                	   class="table table-striped table-bordered table-hover" 
                	   id="dataTables-example"> -->
                <table class="table table-striped table-bordered table-hover">	   
                    <thead>
                        <tr>
                            <th>#번호<!-- Rendering engine --></th>
                            <th>제목<!-- Browser --></th>
                            <th>작성자<!-- Platform(s) --></th>
                            <th>작성일<!-- Engine version --></th>
                            <th>수정일<!-- CSS grade --></th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list }" var="board">
                        <tr class="odd gradeX">
                            <td>${board.bno }</td>
                            <td><a class="move" href="${board.bno}">
                            		${board.title }
                            	<c:if test="${board.replyCnt > 0}">
                            		[${board.replyCnt }] 
                            	</c:if>
                            	</a></td>
                            <td>${board.writer }</td>
                            <td><fmt:formatDate value="${board.regdate}"
                            					pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${board.updateDate}"
                            					pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                
                <!-- 검색 조건 및 키워드 입력 부분 -->
                <div class="row">
                	<div class="col-lg-12">
                		<form id="searchForm" action="/board/list">
                			<select name='type' id="type">
                				<c:set var="type" value="${pageMaker.cri.type}"/>
                				<option value="">검색 조건 지정</option>
                				<option value="T" 
                						<c:out value="${type == 'T'?'selected':''}"/>
                				>제목</option>
                				<option value="C"
                						<c:out value="${type == 'C'?'selected':''}"/>
                				>내용</option>
                				<option value="W"
                						<c:out value="${type == 'W'?'selected':''}"/>
                				>작성자</option>
                				<option value="TC"
                						<c:out value="${type == 'TC'?'selected':''}"/>
                				>제목 or 내용</option>
                				<option value="TW"
                						<c:out value="${type == 'TW'?'selected':''}"/>
                				>제목 or 작성자</option>
                				<option value="TWC"
                						<c:out value="${type == 'TWC'?'selected':''}"/>
                				>제목 or 내용 or 작성자</option>
                			</select>
                			<input type="text" name="keyword" id="keyword" 
                				   value="${pageMaker.cri.keyword}">
		                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		                	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                			<button class="btn btn-default" id="searchBtn">Search</button>
                		</form>
                	</div>
                </div>
                <!-- END 검색 조건 및 키워드 입력 부분 -->
                
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
                <form action="/board/list" id="actionForm">
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
	$('.move').click(function(e){
		e.preventDefault();
		
		$('#actionForm').append("<input type='hidden' name='bno' value='" +
						         $(this).attr('href') + "'>")
						.attr('action', '/board/get')
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
</html>