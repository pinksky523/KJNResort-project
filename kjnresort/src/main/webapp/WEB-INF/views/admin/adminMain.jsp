<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
	<title>KJN RESORT</title>
	<meta charset="UTF-8">
	<meta name="description" content="loans HTML Template">
	<meta name="keywords" content="loans, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- Favicon -->
	<link href="/resources/img/favicon.ico" rel="shortcut icon"/>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
 
	<!-- Stylesheets -->
	<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="/resources/css/font-awesome.min.css"/>
	<link rel="stylesheet" href="/resources/css/owl.carousel.min.css"/>
	<link rel="stylesheet" href="/resources/css/flaticon.css"/>
	<link rel="stylesheet" href="/resources/css/slicknav.min.css"/>

	<!-- Main Stylesheets -->
	<link rel="stylesheet" href="/resources/css/style.css"/>


	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>
<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header Section -->
	<header class="header-section">
		<a href="index.html" class="site-logo">
			<img src="/resources/img/logo.png" alt="">
		</a>
		<nav class="header-nav">
			<ul class="main-menu">
				<li><a href="index.html">리조트안내</a></li>
				<li><a href="/notice/list">공지사항 관리</a></li>
				<li><a href="#">콘도</a>
					<ul class="sub-menu">
						<li><a href="about-us.html">콘도 예약 관리</a></li>
						<li><a href="loans.html">콘도 관리</a></li>
					</ul>
				</li>
				<li><a href="#">이용권</a>
					<ul class="sub-menu">
<<<<<<< HEAD

						<li><a href="/ticket/modify">이용권 관리</a></li>
						<li><a href="/ticket/buyTicketList">이용권 구매내역</a></li>

=======
>>>>>>> branch 'master' of https://github.com/jsnow0819/Project.git
						<li><a href="about-us.html">이용권 판매 관리</a></li>
						<li><a href="loans.html">이용권 관리</a></li>
<<<<<<< HEAD

=======
>>>>>>> branch 'master' of https://github.com/jsnow0819/Project.git
					</ul>
				</li>
				<li><a href="contact.html">이벤트 관리</a></li>
				<li><a href="contact.html">후기 관리</a></li>
				<li><a href="#">1:1문의 관리</a></li>
				<li><a href="#">인재채용</a>
					<ul class="sub-menu">
						<li><a href="/recruit/list">모집공고 관리</a></li>
						<li><a href="/appliance/list">지원자 관리</a></li>
					</ul>
				</li>
				<li>
					<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				</sec:authorize>
				
				<!-- 로그인 안 한 경우 -->
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/common/customLogin'" class="btn btn-secondary" id="customLogin">로그인</button>
				</sec:authorize>
				</li>
				
				<li>
				<!-- 로그인한 경우 -->
				<sec:authorize access="isAuthenticated()">
				<form method="post" action="/common/customLogout">
					<button type="submit" class="btn btn-danger" id="customLogout">로그아웃</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
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

	<!-- Hero Section end -->
	<section class="hero-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="hs-text">
						<br><br><br><br><br>
						<br><br><br><br><br>
						<br><br><br><br><br>
					</div>
				</div>
				
			</div>
		</div>
		<div class="hero-slider owl-carousel">
			<div class="hs-item set-bg" data-setbg="/resources/img/hero-slider/1.jpg"></div>
			<div class="hs-item set-bg" data-setbg="/resources/img/hero-slider/2.jpg"></div>
			<div class="hs-item set-bg" data-setbg="/resources/img/hero-slider/3.jpg"></div>
		</div>
	</section>
	<!-- Hero Section end -->

	<!-- Footer Section -->
	<footer class="footer-section">
		<div class="container">
			<p>KJN 리조트:경기도 광주시 도척면 도척윗로 278, 본사: 서울특별시 마포구 월드컵북로 21 풍성빌딩 4층, 대표번호:02-123-4567. 회원/예약문의:02-123-4567<br>사업자등록번호:123-45-678910 (주) KJN 코퍼레이션, 통신판매 신고번호: 제1234-서울마포-5678호 대표이사:박철연, 개인정보 보호책임자:김병만</p>
			<div class="copyright">
			<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
			Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
			<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
			</div>
		</div>
	</footer>
	<!-- Footer Section end -->
	
	<!--====== Javascripts & Jquery ======-->
	<script src="/resources/js/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.slicknav.min.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/jquery-ui.min.js"></script>
	<script src="/resources/js/main.js"></script>
	
	
	 <script>
    	$("#customLogout").on("click", function(e){
    		e.preventDefault();
    		alert('로그아웃 되었습니다.');
    		$("form").submit();
    	});
    
    </script>
	</body>
</html>
