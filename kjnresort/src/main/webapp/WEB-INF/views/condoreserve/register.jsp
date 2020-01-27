<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  

    <!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<style>
.reserveDiv{background: #EAEAEA; width:900px; height:200px; align-self: center; margin:0 auto; }
.dateDiv{ align-self: center; margin:0 auto; text-align: center;}
.roomTypeDiv{background: #EAEAEA; width:900px; display: none; }
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

.roomTypeRadioDiv{padding-left:30px;}
.radioUl{list-style:none; text-align: center; }
.radioUl>li{display: inline-block; font-size:23px;   margin-right: 55px;}
.roomInfoDiv{ width:900px;  align-self: center; margin:0 auto; display: none; }
.condoImg{width:320px; height:210px; margin-right:50px; float:left; margin-left:200px;}
.roomInfoUl{  margin-top:50px;}
.roomInfoUl>li{margin-bottom: 10px; font-size: 18px; }
.reserve_ok{display:block !important; align-self: center !important; margin:0 auto !important; margin-top:20px !important;}
.reserveInfoUl{font-size:18px; padding-left:100px; margin-top:45px;}
.reserveInfoUl>li{margin-bottom:15px;}
.reserveInfoLi{font-weight: bold; font-size:20px;}
.reserveInfoDiv{display:none;}
.buttonsDiv{float: right; margin-top:75px;}
.buttonsDiv>button{margin-left:15px;}
.condo_reserve_body{ margin-bottom:200px !important;}
.total{font-weight: bold; font-size: 32px; color: red;}
.won{font-size: 28px; font-weight: bold;}
.totalWonDiv{text-align: right; margin-right:25px;}
.reserveP{color:black;}
footer{margin-top:200px; position: relative; top:30%;}
.condo_reserve_body{height: 1000px important!}
</style>
<%@include file="../includes/header.jsp"%>
<section class="condo_reserve_body">
<!-- <body class="condo_reserve_body contents">-->
	<h2>콘도예약</h2>
	<hr>
	<div class="reserveDiv">
		<h3>Step1. 날짜 선택</h3>
		<p class="reserveP">· 체크인/체크아웃 날짜를 선택하세요.</p>
		<div class="dateDiv">
			<span>· 체크인 날짜</span> <input type="date" name="checkIn" id="checkIn" oninput="inputCheckIn()"> <span>· 체크아웃 날짜</span> <input type="date" name="checkOut" id="checkOut" oninput="inputCheckOut()"> <button class="btn btn-primary btn-sm" onclick="search()">검색</button>
		</div>
		<div class="roomTypeDiv">
		<h3>Step2. 객실 선택</h3>
		<p class="reserveP">· 이용할 객실 종류를 선택하세요.</p>
		<div class="roomTypeRadioDiv">
			<ul class="radioUl">
			</ul>
		</div>
		</div>
		<div class="roomInfoDiv">
		 	 <img class="condoImg" src="/resources/img/condo/prime.jpg">
		  		<ul class="roomInfoUl">
		  		</ul>
		 		 <br><br>
		  		<button class="btn btn-primary reserve_ok">예약하기</button>
		</div>
		<div class="reserveInfoDiv">
			<h3>Step3. 예약 정보 확인</h3>
			<p class="reserveP">· 결제전 예약 정보를 확인하세요.</p>
			<ul class="reserveInfoUl">
			</ul>
			<div class="totalWonDiv">
				<span class="total">· 총 금액 : </span><span class="won"></span>
			</div>
			<div class="buttonsDiv">
			<button class="btn btn-default btn-lg" id="reserve_cancle">취소</button><button class="btn btn-primary btn-lg" id="payCharge">결제하기</button>
			</div>
		</div>
		
    </div>
</section>
<%@include file="../includes/footer.jsp"%>

<script>

function test(){
	location.replace('payChargeResult');
}
var IMP = window.IMP; 
IMP.init('imp39785834');


function successPay(payAmount){
	var paidDate=new Date();
	var login_ID=null;
	
	<sec:authorize access="isAuthenticated()">
		login_ID='<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	//보내줘야 할거  2.결제날짜  4.체크인 5.체크아웃 6.방종류 7.숙박일
	var InputDate = finalCheckIn; //입력된 날짜 받아오기
	var dateSplit = InputDate.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split
	year = dateSplit[0]; //첫번째 배열은 년
	month = dateSplit[1]; //월
	day = dateSplit[2]; //일
	var dateCheckIn=new Date(parseInt(year),parseInt(month)-1,parseInt(day));
    InputDate = finalCheckOut; //입력된 날짜 받아오기
	var dateSplit = InputDate.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split
	year = dateSplit[0]; //첫번째 배열은 년
	month = dateSplit[1]; //월
	day = dateSplit[2]; //일
	var dateCheckOut=new Date(parseInt(year),parseInt(month)-1,parseInt(day));
	
	var reserveVO={
			checkIn:dateCheckIn,
			checkOut:dateCheckOut,
			price:payAmount,
			reserveDate:paidDate,
			roomType:roomType,
			nights:nights,
			id:login_ID,
	};
	
	$.ajax({
		type:'post',
		url:'/condoreserve/register',
		data:JSON.stringify(reserveVO),
		contentType:'application/json; charset=utf-8',
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(data){
			var rno=parseInt(data);
			location.replace('payChargeResult/'+rno);
		},
		error:function(xhr,status,error){
			if(error){
				error(status+""+error);
			}
		}
	});

}

$('#payCharge').on("click",function(){

	IMP.request_pay({
	    pg : 'kakaopay',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : 'KJN 리조트 콘도',
	    amount : charge,
	    buyer_tel : '010-1111-1111',
	    buyer_name : '구매자이름',
	}, function(rsp) {
	    if ( rsp.success ) {
	       // var msg = '결제가 완료되었습니다.';
	        //msg += '결제 금액 : ' + rsp.paid_amount;
	       	//msg += '결제승인시각 : ' + rsp.paid_at;
	       	successPay(rsp.paid_amount);
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	    }

	   
	});
	
	
});
$('#reserve_cancle').on("click",function(){
	if(confirm('예약을 취소하시겠습니까?')){
		console.log('예약취소');
		location.href = "/";
	}
});

function getNights(checkIn,checkOut){
	 console.log('숙박일수 함수입니다. 체크인:'+checkIn); 
	 console.log('숙박일수 함수입니다. 체크아웃:'+checkOut); 
	 var ar1 = checkIn.split('-');
	 var ar2 = checkOut.split('-');
	 var da1 = new Date(ar1[0], ar1[1]-1, ar1[2]);
	 var da2 = new Date(ar2[0], ar2[1]-1, ar2[2]);
	 var dif = da2 - da1;
	 var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	   
	 var difDay=parseInt(dif/cDay);
	 console.log(difDay);
	 return difDay;
}
var nights;
var charge;
var finalCheckIn;
var finalCheckOut;

$('.reserve_ok').on("click",function(){
	if($('.reserveInfoUl li').length!=0){
		$('.reserveInfoUl li').remove();
	}
	  finalCheckIn = document.getElementById("checkIn").value; 
	  finalCheckOut = document.getElementById("checkOut").value;
	 nights=getNights(finalCheckIn,finalCheckOut);
	 var rType;
	var li="";
		li="<li><span class='reserveInfoLi'>체크인 : </span><span>"+finalCheckIn+"</span></li>";
		li+="<li><span class='reserveInfoLi'>체크아웃 : </span><span>"+finalCheckOut+"</span></li>";
		li+="<li><span class='reserveInfoLi'>숙박일 수 : </span><span>"+nights+"박</span></li>";
		if(roomType=='P'){rType='프라임P'}
		if(roomType=='D'){rType='디럭스D'}
		if(roomType=='N'){rType='노블N'}
		if(roomType=='R'){rType='로얄R'}
		li+="<li><span class='reserveInfoLi'>객실종류 : </span><span>"+rType+"</span></li>";
		
		$('.reserveInfoUl').append(li);
		$('.reserveInfoDiv').css('display','block');
		$('.won').html(numberWithCommas(totalWon*nights)+' '+'&#8361');
		$('.reserveDiv').css('height','1050px');
		charge=numberWithCommas(totalWon*nights);
		
});
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

var roomType='not checking';
var totalWon;
function showRoomInfo(event){
	//예약정보확인 안보이게
	$('.reserveInfoDiv').css('display','none');
	if($('.roomInfoLi').length==0){
		$('.roomInfoDiv').css('display','block');	
	}else{
	$('.roomInfoLi').remove();
	}
	roomType=event.target.id; //전역변수에 할당
	var location;
	var building;
	var accept;
	var bed;
	var price;
	if(roomType=='P'){$('.condoImg').attr('src','/resources/img/condo/prime.jpg');}
	if(roomType=='D'){$('.condoImg').attr('src','/resources/img/condo/deluxe.jpg');}
	if(roomType=='N'){$('.condoImg').attr('src','/resources/img/condo/noble.jpg');}
	if(roomType=='R'){$('.condoImg').attr('src','/resources/img/condo/royal.jpg');}
	$.getJSON("/condomanage/"+roomType+".json",
			function(data){
		totalWon=data.price;
			var li="";
			li+="<li class='roomInfoLi'>가격(1박) :"+numberWithCommas(data.price)+"원</li>";
			li+="<li class='roomInfoLi'>위치 : "+data.location+"</li>";
			li+="<li class='roomInfoLi'>건물 : "+data.building+"</li>";
			li+="<li class='roomInfoLi'>수용인원 : "+data.accept+"명</li>";
			li+="<li class='roomInfoLi'>"+data.bed+"</li>";
			$('.roomInfoUl').append(li);
			
			$('.reserveDiv').css('height','650px');
		}).fail(function(xhr,status,err){
			if(err){
				console.log(err);
			}
		});
	
	
}

function showAvailableRoomType(data){
	console.log(data);
	
	if(data.length==0){
		alert("예약가능한 객실이 없습니다!");
	}else{
		var roomType;
		//var radioUl=document.createElement('ul'); 
		//radioUl.setAttribute('class', 'radioUl'); 
		//$('.roomTypeRadioDiv').append(radioUl);
		var li="";
		for(d of data){
			if(d=='P')
				roomType='프라임P';
			if(d=='D')
				roomType='디럭스D';
			if(d=='N')
				roomType='노블N';
			if(d=='R')
				roomType='로얄R';
			li+="<li class='radioLi'><input type='radio' id='"+d+"'name='roomType' value='"+d+"'><label class='clickLi' id='"+d+"' for='"+d+"'>"+roomType+"</label></li>";
		}
		$('.radioUl').append(li);
		$('.roomTypeDiv').css('display','block'); //이용가능 객실 종류 출력
		//$(".radioLi").off("click").on("click",function(e){alert('a');});
		$(".clickLi").on("click",showRoomInfo);
	}
	
}



function search(){
	//$(".clickLi").off("click"); //객체가 삭제될때 같이 삭제되므로 굳이 삭제해 줄 필요 없다.
	//방정보 없애기
		$('.roomInfoLi').remove();
		$('.roomInfoDiv').css('display','none');
		
		//예약가능한 객실종류없애기
	$(".radioLi").remove(); //이벤트도 같이 삭제됨
	$('.roomTypeDiv').css('display','none');
	
	$('.reserveDiv').css('height','300px');
	 var checkIn = document.getElementById("checkIn").value; 
	 var checkOut = document.getElementById("checkOut").value;
	 
	 
	 if(checkIn===""&&checkOut===""){
		 alert("체크인/아웃 날짜를 입력해주세요");
	 }
	 else if(checkIn===""){
		 alert("체크인 날짜를 선택해주세요");
	 }else if(checkOut===""){
		 alert("체크아웃 날짜를 선택해주세요");
	 }else{
		
		
	
		$.ajax({
			type:'post',
			url:'/condoreserve/availableRoomType',
			data:{checkIn:checkIn,checkOut:checkOut},
			dataType:"json",
			beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(data){
				showAvailableRoomType(data);			
			},
			error:function(xhr,status,error){
				if(error){
					error(status+""+error);
				}
			}
		});
	 }
	 
}



function inputCheckOut(){
	//$(".clickLi").off("click");
	
	//방정보 없애기
	$('.roomInfoLi').remove();
	$('.roomInfoDiv').css('display','none');
		
		//예약가능한 객실종류없애기
	$(".radioLi").remove();
	$('.roomTypeDiv').css('display','none');
	
	//예약정보확인 없애기
	$('.reserveInfoDiv').css('display','none');
	$('.reserveDiv').css('height','200px');
	 var today=new Date();
	 var checkIn = document.getElementById("checkIn").value; 
	 var checkOut = document.getElementById("checkOut").value;
     console.log("체크인"+checkIn+"체크아웃"+checkOut);
		
	 var dateSplit = checkOut.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split

		var outYear = dateSplit[0]; //첫번째 배열은 년
		var outMonth = dateSplit[1]; //월
		var outDay = dateSplit[2]; //일
	 
	 if(checkIn===""){
		 alert("체크인 날짜를 입력하세요"); 
		 document.getElementById("checkOut").value="";
		 return;
	 }
	 
	 if(outMonth==3) { //지금이 2월인데
		alert("예약기간이 아닙니다.");
		document.getElementById("checkOut").value="";
		return;
	 }
	 if(checkIn>=checkOut){
		 alert("잘못된 날짜입니다. 다시 선택하세요");
		 document.getElementById("checkOut").value="";
		 return;
	 }
	 if(getNights(checkIn,checkOut)>=5){
		 alert("5일 이상 숙박할 수 없습니다.");
		 document.getElementById("checkOut").value="";
		 return;
	 }
	 
}

	function inputCheckIn() {
	//	$(".clickLi").off("click");
		
		//방정보 없애기
		$('.roomInfoLi').remove();
		$('.roomInfoDiv').css('display','none');
		
		//예약가능한 객실종류없애기
		$(".radioLi").remove();
		$('.roomTypeDiv').css('display','none');
		
		//예약정보확인 안보이게
		$('.reserveInfoDiv').css('display','none');
		
		//배경 줄이기
		$('.reserveDiv').css('height','200px');
		document.getElementById("checkOut").value="";
		var today = new Date(); //today.getXX() ->숫자임
		var checkInDate = document.getElementById("checkIn").value; //입력된 날짜 받아오기
		var re=isDateBeforeToday(checkInDate); //입력한 값이 오늘보다 이전날인지 확인
		if(re==1){
			alert("오늘 보다 이전 날짜는 선택할 수 없습니다.");
			document.getElementById("checkIn").value="";
			return;
		}
		
		
		var dateSplit = checkInDate.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split

		var year = dateSplit[0]; //첫번째 배열은 년
		var month = dateSplit[1]; //월
		var day = dateSplit[2]; //일


		if (2<(today.getMonth() + 1) && (today.getMonth() + 1) < 12) { //3월에서 11월일 경우에 -1.
			if (today.getFullYear() == year) { //1-1.올해인데
				if (month < 12) { //1-1-1. 12월 전을 고름
					alert("예약기간이 아닙니다.");
					document.getElementById("checkIn").value = "";
					return;
				}
			}
			if ((today.getFullYear() + 1) == year) { //1-2. 내년 체크인 날짜를 골랐는데
				if (month > 2) { //1-2-1.  2월 초과 인 달을 고른다면 
					alert("예약기간이 아닙니다.");
					document.getElementById("checkIn").value = "";
					return;
				}
			}
			if (year>(today.getFullYear()+1)) { //1-3.후년 부터 안됨
				alert("예약기간이 아닙니다.");
				document.getElementById("checkIn").value = "";
				return;
			} 

		}////3월에서 11월일 경우에
		
		if (today.getMonth()==0||today.getMonth()==1) {//오늘이 1,2월달인 경우에 -2.
			if(year==today.getFullYear()){
				if(2<month){
					alert("예약기간이 아닙니다.");
					document.getElementById("checkIn").value = "";
					return;
				}
			}//end if 같은 년도를 골랐을 때
			if(year>today.getFullYear()){
				alert("예약기간이 아닙니다.");
				document.getElementById("checkIn").value = "";
				return;
			}
		}//end 오늘이 1,2월달인 경우에

	}
	
	function isDateBeforeToday(checkIn) {
		var now = new Date();
		year = now.getFullYear(); // 현재 년도 가져오기
		month = now.getMonth() + 1; // 현재 월 가져오기 (+1)
		if ((month + "").length < 2) { //월이 '1'로 찍히지 않고 '01'로 찍히도록 길이를 받아온다
			month = "0" + month; //길이가 1이라면 앞에 0을 붙여서 '01'형태로 나오게 한다
		}
		date = now.getDate(); // 현재 날짜 가져오기
		if ((date + "").length < 2) { //일이 '7'로 찍히지 않고 '07'로 찍히도록 길이를 받아온다
			date = "0" + date; //길이가 1이라면 앞에 0을 붙여서 '07'형태로 나오게 한다
		}
		today = year + "" + month + "" + date; //오늘 날짜 ex) 20200119

		var InputDate = checkIn; //입력된 날짜 받아오기
		var dateSplit = InputDate.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split

		year = dateSplit[0]; //첫번째 배열은 년
		month = dateSplit[1]; //월
		day = dateSplit[2]; //일

		InputDate = year + "" + month + "" + day; //입력된 값을 더해준다.

		if (parseInt(InputDate) < parseInt(today)) { //int형으로 변환하여 비교한다
			return 1; //오늘 보다 이전 날이면 1반환
		}else{
			return 0; //아니면 0 반환
		}
		
	}
</script>