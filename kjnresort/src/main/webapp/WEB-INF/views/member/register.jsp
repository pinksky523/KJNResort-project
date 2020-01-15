<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css"/>
</head>
<body>
	<h1>회원가입</h1>
	<hr>
	<form>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 col-form-label">이름</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="email" class="form-control" id="inputEmail3">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="text" class="form-control" id="inputEmail3">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 col-form-label">비밀번호</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="password" class="form-control" id="inputPassword3">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 col-form-label">비밀번호 확인</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="password" class="form-control" id="inputPassword3">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 col-form-label">핸드폰번호</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="text" class="form-control" id="inputEmail3">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 col-form-label">생년월일</label>
    <div class="form-group mx-sm-3 mb-2">
      <input type="date" class="form-control" id="inputEmail3">
    </div>
  </div>
  
  
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">성별</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
          <label class="form-check-label" for="gridRadios1">남</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
          <label class="form-check-label" for="gridRadios2">여</label>
        </div>
        
      </div>
    </div>
  
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 col-form-label">주소</label>
    <div class="form-group col-md-6">
      <input type="text" class="form-control" id="inputEmail3">
    </div>
  </div>
  
  
  <div class="form-group row">
    <div class="col-sm-10">
   	  <button type="button" class="btn btn-secondary">취소</button>
      <button type="submit" class="btn btn-primary">가입완료</button>
    </div>
  </div>
</form>


<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>