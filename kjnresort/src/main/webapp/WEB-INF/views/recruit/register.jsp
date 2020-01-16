<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">모집공고 게시판 관리</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>

<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                게시글 등록
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
            
			<form method="post" action="/recruit/register" role="form">
			
	            <div class="form-group">
	                <label>제목: </label>
	                <input class="form-control" name="title"></div>
	            <div class="form-group">
	                <label>상태: </label>
	                <input class="form-control" name="status"></div>
	            <div class="form-group">
	                <label>접수마감: </label>
	                <input class="form-control" name="deadLine"></div>
	            <div class="form-group">
                    <label>내용: </label>
                    <textarea class="form-control" rows="8" name="content"></textarea></div>
                <button type="submit" class="btn btn-primary pull-right">등록</button>
                <button type="submit" data-oper='list' class="btn btn-secondary pull-right">취소</button>
			</form>
            </div>	<!-- /.panel-body -->
        </div>		<!-- /.panel -->
    </div>			<!-- /.col-lg-6 -->
</div>				<!-- /.row -->


<%@ include file="../includes/footer.jsp" %>