<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<h2>이벤트</h2>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                4계절을 골고루 즐기는 행복과 웃음으로 가득한 KJN리조트 이벤트입니다.
            </div>
            <hr style="width: 70%">
                
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
                    <thead class="thead-light">
                        <tr>
                            <th>NO.</th>
                            <th>이미지</th>
                            <th>제목</th>
                            <th>기간</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="event" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td id="imgTd">
                            <input type="hidden" id="hiddenEventNo" value="${event.eventNo}">
                            <div id="thumbResult"><ul style="list-style: none;"></ul></div></td>
                            <td><a class="move" href='${event.eventNo}'>
                            		${event.title}
                            	</a>
                            </td>
                           	<td>${event.eventStart} ~ ${event.eventEnd}</td>
                           	<td>${event.viewCnt}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                
                
                
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
								  <sec:authorize access="hasRole('ROLE_ADMIN')">
								   <div class="pull-center" style="text-align: center;">
					               <button id="regBtn" type="button" class="btn btn-primary pull-center">
					         			이벤트 등록	
					         		</button> 
					         		</div>
					             </sec:authorize>
                            </div>
   							
   
   
   <!-- 페이지 번호 누를 때마다 해당 pageNum(페이지 번호)의 목록 amount(출력 데이터 갯수)개 출력하기 위해 컨트롤러(list)로 파라미터(눌린 숫자에 해당하는 데이터) 전달 -->
    <form id="actionForm" action="/event/list" method="get">
    	<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cri.pageNum}">
    	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    </form>
   
   
   
   
   
   
   
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
	var hiddenEventNo = $("#imgTd").find("#hiddenEventNo").val();
	
	
	//게시물 하나에 대한 첨부파일 목록 가져오기
	$.getJSON("/event/getAttachList", {eventNo : <c:out value='hiddenEventNo'/>},
			function(result){
				console.log("attach list.........");
				console.log(result);	//console.log("attach list........." + result); 이런 식으로 쓰면 콘솔에 object라고 뜸
				
				//업로드된 결과를 화면에 섬네일 등을 만들어서 처리
					if(!result || result.length == 0){return;}
					
					var li = "";
					
					$(result.slice(0,1)).each(function(index, aFileDTO){	//첨부파일 array중 인덱스0번째(썸네일용)만 골라내기
//						$('.uploadResult ul').append('<li>' + aFileDTO.fileName + '</li>');
						//이미지가 아니면 attach.png 표시
						//클릭하면 다운로드
						aFileDTO.fileName = aFileDTO.fileName.substring(aFileDTO.fileName.indexOf(".")+1, aFileDTO.fileName.length);
						if(aFileDTO.fileType == false){
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/" + aFileDTO.uuid + "_" + aFileDTO.fileName);
							var fileLink = filePath.replace(new RegExp(/\\/g), "/");
							
							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/resources/img/attach.png'>"
								+ "</div></li>";
							
						}else{	
							var filePath = encodeURIComponent(aFileDTO.uploadPath + "/s_" + aFileDTO.uuid + "_" + aFileDTO.fileName);

							li += "<li data-path='" + aFileDTO.uploadPath + "'"
								+ "data-uuid='" + aFileDTO.uuid + "' data-filename='" + aFileDTO.fileName 
								+ "' data-type='" + aFileDTO.fileType + "'><div>"
								+ "<img src='/display?fileName=" + filePath + "'>"
								+ "</div></li>";
							
							//섬네일 클릭 시 showImage() 호출
//							var originPath = aFileDTO.uploadPath + "\\" + aFileDTO.uuid + "_" + aFileDTO.fileName;
//							originPath = originPath.replace(new RegExp(/\\/g), "/");	//역슬래시를 슬래시로 바꾸는 처리
						}
					});
					$("#thumbResult ul").append(li);
				
			}).fail(function(xhr, status, err){
				console.log(err);
			});
	
	
	
	
	
	
	
	
	
	
	// 글쓰기 버튼을 누르면 게시글 작성 화면으로 이동
	$('#regBtn').on("click",function(){
		self.location = "/event/register";
	});


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
	$("#actionForm").append("<input type='hidden' name='eventNo' value='" + $(this).attr("href") + "'>");
	
	//list로 되어있는 폼의 action을 get으로 변경
	$("#actionForm").attr("action", "/event/get");
	//폼을 이용해 컨트롤러로 전달
	$("#actionForm").submit();
	
	
});


});

</script>
<%@ include file="../includes/footer.jsp" %>