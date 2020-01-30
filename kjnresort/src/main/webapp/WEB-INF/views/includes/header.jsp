<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
	<title>KJN RESORT</title>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<meta charset="UTF-8">
	<meta name="description" content="loans HTML Template">
	<meta name="keywords" content="loans, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- Favicon -->
	<link href="img/favicon.ico" rel="shortcut icon"/>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
 	
	<!--   Stylesheets -->
	<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="/resources/css/font-awesome.min.css"/>
	<link rel="stylesheet" href="/resources/css/owl.carousel.min.css"/>
	<link rel="stylesheet" href="/resources/css/flaticon.css"/>
	<link rel="stylesheet" href="/resources/css/slicknav.min.css"/>
	<link rel="stylesheet" href="/resources/css/common.css"/>

	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
     <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> 
	<link rel="stylesheet" href="/resources/css/style.css"/>


	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>
<body class="contents" style="height: 100%;">
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header Section -->
	<header class="header-section">
		<a href="/" class="site-logo">
			<img src="/resources/img/logo.png" alt="">
		</a>
		<nav class="header-nav">
			<ul class="main-menu">
				<li><a href="/common/resortInfo">리조트안내</a></li>
				<li><a href="/notice/list">공지사항</a></li>
				<li><a href="#">콘도</a>
					<ul class="sub-menu">
						<li><a href="/condoreserve/register">콘도 예약</a></li>
						<li><a href="/condoreserve/list">콘도 예약내역</a></li>
					</ul>
				</li>
				<li><a href="#">이용권</a>
					<ul class="sub-menu">
						<li><a href="/ticket/buyTicket">이용권 구매</a></li>
						<sec:authorize access="isAuthenticated()">
							<form id="buyTicketListUser" action="/ticket/buyTicketListUser" method="post">
								<input type="submit" id="ticketBtn" value="   이용권 구매내역">
								<input type="hidden" name="id" value='<sec:authentication property="principal.username"/>'>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					 		</form>
					 		</sec:authorize>
					</ul>
				</li>
				<li><a href="/event/list">이벤트</a></li>
				<li><a href="/review/list">후기</a></li>
				<li><a href="#">1:1문의</a>
					<ul class="sub-menu">
						<li><a href="/qna/register">문의하기</a></li>
						<li><a href="/qna/list">문의내역</a></li>
					</ul>
				</li>
				<li><a href="#">인재채용</a>
					<ul class="sub-menu">
						<li><a href="/recruit/list">모집공고</a></li>
						<li><a href="/appliance/myList">지원내역조회</a></li>
					</ul>
				</li>
				<li>
				<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="pinfo"/>'>
				
				  <c:if test="${pinfo.username ne 'admin'}">		<!-- 관리자로 로그인할 경우 아무버튼 없음 -->
				  	<form id="mypageForm" action="/member/mypage" method="get">
						<button type="submit" class="btn btn-secondary" id="mypage">마이페이지</button>
					 </form>
 				 </c:if>
				</sec:authorize>
				
				<!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/common/customLogin'" class="btn btn-secondary" id="customLogin">로그인</button>
				</sec:authorize>
				</li>
				
				<li>
				<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				<button type="button" onclick="location.href='/common/customLogout'" class="btn btn-danger" id="customLogout">로그아웃</button>
				</sec:authorize>
				
				<!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/common/memberJoin'" class="btn btn-danger" id="register">회원가입</button>
				</sec:authorize>
				</li>
			
			</ul>
		</nav>
	</header>
	
	<!-- Header Section end -->
	
	<!-- JQuery -->
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

