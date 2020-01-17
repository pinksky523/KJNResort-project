<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용권 구매</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/common.css"/>
</head>
<body>
	<h1>이용권 구매</h1>
	<hr>
	<form id="buyForm" method="post" action="buyTicketResult">
   <table width="100%" style="padding:5px 0 5px 0; ">
   	
      <tr>
         <th>리프트권 선택</th>
         <td>리프트 미선택                      <input type="radio" name="lift" class="form-control" id="liftNoUse" value="0" style="width: 35%"></td>
         <td>4시간 이용권(50,000원/1매)<input type="radio" name="lift" class="form-control" id="liftUse"   value="1" style="width: 35%" checked="checked"></td>
      </tr>
      <tr>
         <th><span id="liftAmount">수량 선택
         
        <select name="liftAmount" class="form-control" id="liftAmount"  style="width: 70%" >
        	<option value="1">1 </option>
        	<option value="2">2 </option>
        	<option value="3">3 </option>
        	<option value="4">4 </option>
        	<option value="5">5 </option> 
        </select> </span>	</th>
       </tr>
       <tr>
         <th>장비렌탈 선택</th>
         <td>장비렌탈 미선택<input type="radio" name="tool" class="form-control" id="toolNoUse" value="0" style="width: 35%" ></td>
         <td>4시간 이용권(50,000원/1매)<input type="radio" name="tool" class="form-control" id="toolUse" value="1" style="width: 35%" checked="checked"></td>
       </tr>
       
       <tr>
         <th> <span id="liftAmount">수량 선택
         
        <select name="toolAmount2" class="form-control" id="toolAmount2"  style="width: 70%" >
        	<option value="1">1</option>
        	<option value="2">2</option>
        	<option value="3">3</option>
        	<option value="4">4</option>
        	<option value="5">5</option>
        </select>	</span> </th>
       </tr>
       <tr>
       		<th>총금액</th>
       		<td><!-- 리프트 옵션의 수량 * 50,000 + 장비 옵션의 수량 * 50,000 --></td>
       </tr>
       <tr>
         <td colspan="2" align="right">
		    <button type="submit" class="btn btn-primary" id="formButton">다음</button>
         </td>
       </tr>
    </table>
</form>


<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script>
$(function(){	
	// 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=lift]").click(function(){
 
        if($("input[name=lift]:checked").val() == "1"){
            $("#liftAmount").attr("hidden",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=lift]:checked").val() == "0"){
              $("#liftAmount").attr("hidden",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
	
    $("input:radio[name=tool]").click(function(){
    	 
        if($("input[name=tool]:checked").val() == "1"){
            $("#toolAmount2").attr("hidden",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=tool]:checked").val() == "0"){
              $("#toolAmount2").attr("hidden",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
    
    
});

</script>
</body>
</html>