<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="../includes/header.jsp" %>
<div>
    <div class="col-lg-12" style="padding-top: 120px; text-align: center;">
        <h2>모집공고 게시판</h2>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="padding-bottom: 20px">
        <div>
            <div style="text-align: center;">
                KJN리조트와 함께 할 패기 넘치는 인재를 기다립니다.
            </div>
            <hr style="width: 70%">
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table class="table table-bordered table-hover" style="width: 70%; margin: auto;">	   
                    <thead class="thead-light">
                        <tr>
                            <th>NO.</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="recruit">
                        <tr>
                            <td>${recruit.recruitNo}</td>
                            <td><a href='/recruit/get?recruitNo=${recruit.recruitNo}'>
                            		${recruit.title}
                            	</a>
                            </td>
                            <td><fmt:formatDate value="${recruit.regDate}" pattern="yy-MM-dd"/></td>
                           	<td>${recruit.status}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><!-- END 게시물 출력 테이블 -->
                <sec:authorize access="hasRole('ROLE_ADMIN')">
	                <button onclick="tt()" id="regBtn" type="button" class="btn btn-primary pull-right">
	          			글쓰기	
	          		</button> 
                </sec:authorize>
                
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

	//result 값을 저장 - 게시글을 등록/수정/삭제한 경우 
	var result = '${result}';
	
	// result 값을 저장 - 게시글을 등록한 경우
	checkModal(result);
	
	// history를 사용해서 뒤로가기를 눌렀을때, 모달창이 다시 뜨지 않게 한다.
	history.replaceState({}, null, null);
	
	//result 값이 있는지 확인하는 함수
	function checkModal(result){
		if(result === '' || history.state ){
			return;
		}
		
		if(parseInt(result)>0){
			$('.modal-body').html(result + '번 게시글이 등록되었습니다.');	
		}
		
		$('#myModal').modal('show');
	}
	
	function tt() {
		alert("zz");
	}
	// 글쓰기 버튼을 누르면 게시글 작성 화면으로 이동
	$('#regBtn').on("click",function(){
		self.location = "/recruit/register";
	});
});

</script>
<%@ include file="../includes/footer.jsp" %>