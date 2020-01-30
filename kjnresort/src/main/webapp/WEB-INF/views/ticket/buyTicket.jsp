<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
.buyTicketDiv{background: #EAEAEA; width:900px; height:700px; align-self: center; margin:0 auto; }
.dateDiv{ align-self: center; margin:0 auto; text-align: center;}
hr{text-align: center; width:1000px;}
h2{text-align: center !important;}
h3{padding-left: 30px; padding-top: 30px;  text-align: left !important; margin-bottom:10px !important;}

p{padding-left:30px;}
     table
    {
        border:1px solid black;
        text-align:center;
        width:30%;
    }
footer{margin-top:300px; position: relative; top:30%;}
input[type=radio]{ width: 30px; height: 30px; margin-bottom: 5px;}

.buyTicket_body{height: 1000px important!}
.btDiv{padding-left: 50px; text-align: left;}
.liftSpan{padding-right: 83px;}
.toolSpan{padding-right: 70px;}
.total{font-weight: bold; font-size: 32px; color: red;}



</style>
<%@ include file="../includes/header.jsp" %>    

<section class="buyTicket_body">
	<h2>이용권 구매</h2>
	<hr>
	<div class="buyTicketDiv">
		<h3>리프트권 선택</h3>
		
		<div class="btDiv">
			<span class="liftSpan">· 리프트 미선택 </span> <input type="radio" name="lift" id="liftNoUse" value="0" >
		</div>
		
		<div class="btDiv">
			<span>· 4시간 이용권(<c:out value="${tPrice.price}"/>원/1매)</span> <input type="radio" name="lift" id="liftUse"   value="1" checked="checked">
		</div>
         <br>
        <div class="btDiv">
			<span id="liftAmount">수량 선택
         	<select name="liftAmount" class="form-control" id="Amount"  style="width: 50%">
        		<option value="0">0 </option>
        		<option value="1">1 </option>
        		<option value="2">2 </option>
        		<option value="3">3 </option>
        		<option value="4">4 </option>
        		<option value="5">5 </option> 
        	</select> 
        	</span>
		</div> 	                     
         
     	<h3>장비렌탈 선택</h3>
		
		<div class="btDiv">
			<span class="ToolSpan">· 장비렌탈 미선택</span> <input type="radio" name="tool" id="toolNoUse" value="0"  >
		</div>
		
		<div class="btDiv">
			<span>· 4시간 이용권(<c:out value="${ttPrice.price}"/>원/1매)</span> <input type="radio" name="tool" id="toolUse" value="1" checked="checked">
		</div>
         <br>
        <div class="btDiv">
			<span id="toolAmount">수량 선택
         	<select name="toolAmount" class="form-control" id="Amount"  style="width: 50%">
        		<option value="0">0</option>
        		<option value="1">1</option>
        		<option value="2">2</option>
        		<option value="3">3</option>
        		<option value="4">4</option>
        		<option value="5">5</option>
        	</select>
        	</span>
		</div>
      
        <div class="buyInfoDiv">
			<h3>구매 정보 확인</h3>
			<div class="btDiv">
				<span class="total">· 총 금액 </span><span id="text1" class="form-control">원</span>
			</div>
			<div class="buttonsDiv">
			<input type="hidden" name="id" value="user00">
         	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<button class="btn btn-default" id="reserve_cancle">취소</button><button type="submit" class="btn btn-primary" id="payCharge">결제</button>
			</div>
		</div> 
      
	</div>

      

</section>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>

function test(){
	location.replace('buyTicketResult');
}

//START 카카오페이
var IMP = window.IMP; // 생략가능
IMP.init('imp00967940'); 
$('#payCharge').on("click",function(){

	IMP.request_pay({
	    pg : 'kakaopay',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : 'KJN 리조트 스키',
	    amount : (${tPrice.price} * $("select[name=liftAmount]").val() + ${ttPrice.price} * $("select[name=toolAmount]").val()),
	    buyer_tel : '010-1111-1111',
	    buyer_name : '구매자이름',
	}, function(rsp) {
	    if ( 1 ) {//rsp.success
	       // var msg = '결제가 완료되었습니다.';
	        //msg += '결제 금액 : ' + rsp.paid_amount;
	       	//msg += '결제승인시각 : ' + rsp.paid_at;
	       	alert("결제에 성공하였습니다.");
	       	successPay(rsp.paid_amount);
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	    }
	   
	});
	
});
//END 카카오페이
	
$(function(){	
	
	//총금액 표시
	$("select[id=Amount]").change(function(obj){
 		var str = document.getElementById("text1");
 		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 	
 		 if($("input[name=lift]:checked").val()  && $("input[name=tool]:checked").val()) {
 			document.getElementById("text1").innerHTML = (lift + tool) + "원";
 		} 
	}); 
	
	$("select[id=Amount]").change(function(obj){
		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 		 if($("input[name=lift]:checked").val()  && $("input[name=tool]:checked").val() == "0") {
 			document.getElementById("text1").innerHTML = lift + "원";
 		}
	});
	
	$("select[id=Amount]").change(function(obj){
		var lift = ($("select[name=liftAmount]").val() * ${tPrice.price});
 		var tool = ($("select[name=toolAmount]").val() * ${ttPrice.price});
 		 if($("input[name=lift]:checked").val() == "0"  && $("input[name=tool]:checked").val()) {
 			document.getElementById("text1").innerHTML = tool + "원";
 		}
	});
	
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
            $("#toolAmount").attr("hidden",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=tool]:checked").val() == "0"){
              $("#toolAmount").attr("hidden",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
        
});

function successPay(payAmount){
	var paidDate=new Date();
	var login_ID=null;
 	<sec:authorize access="isAuthenticated()">
 		login_ID='<sec:authentication property="principal.username"/>';
	</sec:authorize> 
	//6.buyDate, status, review ticketNo는 쿼리문 에서 보내기 
	//보내줘야 할거  1.id, 2.type, 3.liftAmount, 4.toolAmount, 
	
	var ticket={
			id:login_ID,
			type:'both',
			liftAmount:$("select[name=liftAmount]").val(),
			toolAmount:$("select[name=toolAmount]").val(),
			totalPrice:${tPrice.price} * $("select[name=liftAmount]").val() + ${ttPrice.price} * $("select[name=toolAmount]").val()
	};
	$.ajax({
		type:'post',
		url:'/ticket/buyTicket',
		data:JSON.stringify(ticket),
		contentType:'application/json; charset=utf-8',
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(data){
			var ticketNo = parseInt(data);
			location.replace('buyTicketResult/'+ ticketNo);
			console.log("카카오결제 success check : " + ticketNo);
		},
		error:function(xhr,status,error){
			if(error){
				error(status+""+error);
				console.log("카카오결제 error check : " + error);
			}
		}
	});
};

</script>


<%@ include file="../includes/footer.jsp" %>