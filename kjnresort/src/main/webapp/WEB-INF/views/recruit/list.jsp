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

<body>
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
                            <th>#NO.<!-- Rendering engine --></th>
                            <th>제목<!-- Browser --></th>
                            <th>등록일<!-- Engine version --></th>
                            <th>상태<!-- CSS grade --></th>
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
	
	//게시물 조회 링크 처리
	$('.move').click(function(e){
		e.preventDefault();
		
		$('#actionForm').append("<input type='hidden' name='recruitNo' value='" +
						         $(this).attr('href') + "'>")
						.attr('action', '/recruit/get')
						.submit();
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
	
	//Register New Board 버튼을 누르면 게시글 작성 화면으로 이동
	$('#regBtn').click(function(){
		self.location = "/recruit/register";
	});
});

</script>
</body>
</html>