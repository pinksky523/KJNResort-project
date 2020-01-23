<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/table.css"/>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>공지사항</h2>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                공지사항, 상품안내 등의 소식 등을 모아 고객에게 빠르게 전달해 드립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="pull-right">
		     	<div class="col-lg-12">
		     		<form id='searchForm' action="/notice/list" method="get">
		     			<select name="type">
		     				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>검색 조건 지정</option>
		     					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
		     					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
		     					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
		     			</select>
		     			<input type="text" name="keyword" placeholder="내용을 입력해주세요." value='<c:out value="${pageMaker.cri.keyword}"/>'/>
		     			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
		     			<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
		     			<button class='btn btn-default'>검색</button>
		     		</form>
		     	</div>
		     </div>
		     
            <div class="panel-body">
                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
                    <thead class="thead-light">
                        <tr>
                            <th>No.</th>
                            <th>제목</th>
                            <th>작성일시</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="notice">
                        <tr>
                        	<td>${notice.noticeNo}</td>
                            <td><a class="move" href="<c:out value="${notice.noticeNo}"/>">
                            <c:out value="${notice.title}"/></a></td>
                           	<td><fmt:formatDate value="${notice.regDate}" pattern="yy-MM-dd"/></td>
                           	<td>${notice.viewCnt}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
            	<sec:authorize access="hasRole('ROLE_ADMIN')">
	                <button id="regBtn" type="button" class="btn btn-primary pull-right">
	          			글쓰기	
	          		</button> 
                </sec:authorize>
   			
   			
   			<!-- 페이지 번호 출력 -->
				 <div style="text-align: center;">
				 	<ul class="pagination">
				 		<c:if test="${pageMaker.prev }">
				 			<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1 }">Previous</a></li>
				 		</c:if>
				 		
				 		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				 			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':'' }">
								<a href="${num}">${num}</a></li>
				 		</c:forEach>	
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
							<a href="${pageMaker.endPage + 1 }">Next</a></li>
						</c:if>	
				 	</ul>
				 </div>
				 
			<!-- 페이지 번호 클릭 시 페이지 번호와 출력 데이터 갯수를 전달 -->
			<form id="actionForm" action="/notice/list" method="get">
				 	<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}">
				 	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				 	<input type="hidden" name="type" value="${pageMaker.cri.type}">			<!-- 검색 조건과 키워드 파라미터 추가 -->
				 	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			</form>
			<!-- END 페이지 번호 출력 -->  
			
            </div>		<!-- /.panel-body -->
        </div>			<!-- /.panel -->
    </div>				<!-- /.col-lg-6 -->
</div>					<!-- /.row -->

<script>
$(function(){
	
		//페이지 번호 링크 처리
		$('.paginate_button a').click(function(e){
			 
			 e.preventDefault();						// 페이지가 눌렸을때 화면이 그냥 넘어가는 것을 막아준다.
			 $('#pageNum').val($(this).attr("href"));
			 $("#actionForm").submit();
		});
		
		//게시물 조회 링크 처리
		$('.move').click(function(e){
			 
			 e.preventDefault();						
			// actionForm에 hidden으로
			// name 속성 추가 값은 bno 지정
			// value 속성 값은 ~~~ 지정한 후 append
			
			 $("#actionForm").append("<input type='hidden' name='noticeNo' value='"+
					 					$(this).attr("href")+"'>");								
			 											
			 $("#actionForm").attr("action","/notice/get")	// actionForm의 action 속성을 /board/get으로 변경
			 $("#actionForm").submit();
		});
		
		
		//검색 버튼 이벤트 처리
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			 if(!searchForm.find("option:selected").val()){
				 alert("검색종류를 선택하세요.");							//검색 조건을 지정하지 않은 경우
				 return false;
			 }
			 if(!searchForm.find("input[name='keyword']").val()){			//검색어를 입력하지 않은 경우
				 alert("검색어를 입력하세요.");
				 return false;
			 }
			 
			 searchForm.find("input[name='pageNum']").val("1");				//검색 결과 페이지 번호가 1이 되도록 처리
			 e.preventDefault();
			 
			 searchForm.submit();
		});
		
		// 글쓰기 버튼을 누르면 게시글 작성 화면으로 이동
		$('#regBtn').on("click",function(){
			self.location = "/notice/register";
		});
});	
</script>

<%@ include file="../includes/footer.jsp" %>