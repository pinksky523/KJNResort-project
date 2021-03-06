<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<sec:authentication property="principal" var="pinfo"/>
<c:choose>
	<c:when test="${pinfo.username eq 'admin'}">
		<%@ include file="../includes/adminHeader.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="../includes/header.jsp" %>
	</c:otherwise>
</c:choose>
<link rel="stylesheet" href="/resources/css/table.css"/>
        <h2>회원 관리</h2>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
            </div>
            <hr style="border: solid 2px lightgray !important; width: 60% !important;">
            
            
            
            <!-- 검색 조건 및 키워드 입력 부분 -->
                            <div class="pull-center" style="text-align: center;">
                            	<div class="col-lg-12" style="margin-bottom: 10px;">
                            		<form id='searchForm' action="/member/list" method="get">
                            		<select name= 'type'>
                            				<!-- <c:out value="${pageMaker.cri.type == null? 'selected':''}"/> 선택된 값이 유지되게 하기 (페이지 이동 시에도) -->
                            				<!-- <c:set var="type" value="${pageMaker.cri.type}"/> 변수를 지정해서 쓰면 약간 더 편함 -->
                            				<c:set var="type" value="${pageMaker.cri.type}"/>
                            				<option value = "OX" <c:out value="${type eq 'OX'? 'selected':''}"/>>전체</option>
                            					<option value="O" <c:out value="${type eq 'O'? 'selected':''}"/>>일반</option>
                            					<option value="X" <c:out value="${type eq 'X'? 'selected':''}"/>>정지</option>
                            			</select>
                            			
                            			<select name= 'type2'>
                            				<!-- <c:out value="${pageMaker.cri.type == null? 'selected':''}"/> 선택된 값이 유지되게 하기 (페이지 이동 시에도) -->
                            				<!-- <c:set var="type" value="${pageMaker.cri.type}"/> 변수를 지정해서 쓰면 약간 더 편함 -->
                            				<c:set var="type2" value="${pageMaker.cri.type2}"/>
                            				<option value = "" <c:out value="${type2 == null? 'selected':''}"/>>검색 조건 지정</option>
                            					<option value="I" <c:out value="${type2 eq 'I'? 'selected':''}"/>>아이디</option>
                            					<option value="N" <c:out value="${type2 eq 'N'? 'selected':''}"/>>이름</option>
                            					<option value="P" <c:out value="${type2 eq 'P'? 'selected':''}"/>>핸드폰번호</option>
                            			</select>
                            			<!-- value="${pageMaker.cri.keyword}" 검색 키워드가 유지되게 하기 (페이지 이동 시에도) -->
                            			<input type="text" id="keyword" name="keyword" value="${pageMaker.cri.keyword}"/>
                            			<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
    									<input type="hidden" name='type2' value='<c:out value="${pageMaker.cri.type2}"/>'>
                            			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            			<button class="btn btn-default" id="searchBtn"><span class="glyphicon glyphicon-search"></span></button>
                            		</form>
                            	</div>
                            </div>
            
            
            
            
            
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
                    <thead class="thead-light">
                        <tr>
                            <th>NO.</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>핸드폰번호</th>
                            <th>회원구분</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="member" varStatus="status">
                        <tr>
                            <td>${member.rn}</td>
                            <td>
                            <c:if test="${member.id eq 'admin'}">
                            	<c:out value="admin"></c:out>
                            </c:if>
                            <c:if test="${member.id ne 'admin'}">
                            <a class="move" href='${member.id}'>
                            		${member.id}
                            </a>
                            </c:if>
                            </td>
                            <td>${member.name}</td>
                           	<td>${member.phoneNumber}</td>
                           	<td>
                           	
                           	
                           	<!-- 1일 경우 '일반회원' 0일경우 '정지회원' -->
			           		<c:if test="${member.status eq 1}">
			           		<c:choose>
			           			<c:when test="${member.id eq 'admin'}">
			           				<input type="text" value="관리자계정" style="color: blue; font-weight: bold; border: 0; text-align: center;" readonly>
			           			</c:when>
			           			<c:otherwise>
			           				<input type="text" value="일반회원" style="color: green; font-weight: bold; border: 0; text-align: center;" readonly>
			           			</c:otherwise>
			           			</c:choose>
			           		</c:if>
			           		<c:if test="${member.status eq 0}">
			           			<input type="text" value="정지회원" style="color: red; font-weight: bold; border: 0; text-align: center;" readonly>
			           		</c:if>
                           	</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                <br>
                
                 
                            
                            
                            
                <!-- 페이지 번호 출력 -->
                            <div class="pull-center" style="text-align: center;">
                            	 <ul class="pagination">
                            	 	<c:if test="${pageMaker.prev}">
									    <li class="paginate_button previous">
									      <a href="${pageMaker.startPage -1}">Previous</a>
									    </li>
								    </c:if>
								    
								    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
								    <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''} ">
								    	<a href="${num}">${num}</a>
								    </li>
								    </c:forEach>
								    
								    <c:if test="${pageMaker.next}">
									    <li class="paginate_button next">
									      <a href="${pageMaker.endPage +1}">Next</a>
									    </li>
								    </c:if>
								  </ul>
                            </div>
                            
                            
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->


<!-- 페이지 번호 누를 때마다 해당 pageNum(페이지 번호)의 목록 amount(출력 데이터 갯수)개 출력하기 위해 컨트롤러(list)로 파라미터(눌린 숫자에 해당하는 데이터) 전달 -->
    <form id="actionForm" action="/member/list" method="get">
    	<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cri.pageNum}">
    	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    	<!-- 검색 이후 페이지를 이동해도 검색 결과가 동일하게 유지되도록 하기 -->
    	<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
    	<input type="hidden" name='type2' value='<c:out value="${pageMaker.cri.type2}"/>'>
    	<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
    </form>
    
    
<script>
var msg = '<c:out value="${msg}"/>';	

//result 값이 있는지 확인하는 함수 호출
checkModal(msg);
history.replaceState({}, null, null);


//메세지가 존재하면 alert창 띄우기
function checkModal(){
	//값이 없으면 리턴시킴
	if(msg === '' || history.state){
		return;
	}
	
	//값이 있으면 메시지 띄우기
	if(msg !== ''){
		alert(msg);
	}
	
}

//페이지 번호 누를 때마다 해당 pageNum(페이지 번호)의 목록 amount(출력 데이터 갯수)개 출력
//클릭할때마다 테이블이 찌그러지는 문제가 있긴 함
//그냥 a태그의 href에 써도 되긴 한데 책을 존중하여 javascript로 처리함
$(".paginate_button a").click(function(e){
	//a태그의 href가 적혀있는 곳으로 무조건 넘어가지 않게 하기 위해
	//이걸 쓰지 않으면 2페이지 클릭 시 localhost:8090/board/2로 넘어감
	
	e.preventDefault();
	
//	alert("clicked!");
	
	//폼의 hidden 속성에 있는 pageNum 파라미터의 값에 눌린 페이지 번호의 값 넣고
	$("#pageNum").val($(this).attr('href'));
	
	//폼을 이용해 컨트롤러로 전달
	$("#actionForm").submit();
});

//게시글 목록에서 제목을 클릭했을 때 컨트롤러(get)로 pageNum과 amount를 같이 보내도록 함
$(".move").click(function(e){
	
	e.preventDefault();
	
	//폼의 hidden 속성에 있는 id 파라미터의 값에 게시물 번호의 값 넣고
	$("#actionForm").append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
	
	//list로 되어있는 폼의 action을 get으로 변경
	$("#actionForm").attr("action", "/member/get");
	//폼을 이용해 컨트롤러로 전달
	$("#actionForm").submit();
	
	
});

//검색 버튼 이벤트 처리
var searchForm = $("#searchForm");

$("#searchForm button").on("click", function(e){		
		if($("#keyword").val() == null || $("#keyword").val() == "") {
			alert("검색어를 입력해주세요");
			$("#keyword").focus();
		} else {
			//검색 결과 페이지 번호가 1페이지가 되도록 처리
			searchForm.find("input[name='pageNum']").val("1");
	
			//검색 버튼을 클릭하면 폼 전송 막기
			e.preventDefault();
			
			searchForm.submit();
		}
});


</script>
<%@ include file="../includes/footer.jsp" %>