<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
.reserveBox{background: #EAEAEA; width:900px; height:200px; align-self: center; margin:0 auto; }
.dateBox{ align-self: center; margin:0 auto; text-align: center;}
h1{text-align: center;}
hr{text-align: center; width:1000px;}
h2{padding-left: 30px; padding-top: 30px; }
p{padding-left:30px;}
     table
    {
        border:1px solid black;
        text-align:center;
        width:30%;
    }


</style>
<body>
	<h1>콘도예약</h1>
	<hr>
	<div class="reserveBox">
		<h2>Step1. 날짜 선택</h2>
		<p>· 체크인/체크아웃 날짜를 선택하세요.</p>
		<div class="dateBox">
			<span>· 체크인 날짜</span> <input type="date" name="checkIn" id="checkIn" oninput="inputCheckIn()"> <span>· 체크아웃 날짜</span> <input type="date" name="checkOut" id="checkOut" oninput="inputCheckOut()"> <button class="btn btn-primary btn-sm" onclick="search()">검색</button>
		</div>
    </div>

</body>
<script>
function search(){
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
			success:function(roomList,status,xhr){
				if(callback){
					console.log(roomList);
				}
			},
			error:function(xhr,status,error){
				if(error){
					error(error);
				}
			}
		});
	 }
	 
}
function inputCheckOut(){
	 var checkIn = document.getElementById("checkIn").value; 
	 var checkOut = document.getElementById("checkOut").value;
   
		
	 var ar1 = checkIn.split('-');
	 var ar2 = checkOut.split('-');
	 var da1 = new Date(ar1[0], ar1[1], ar1[2]);
	 var da2 = new Date(ar2[0], ar2[1], ar2[2]);
	 var dif = da2 - da1;
	 var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	   
	 var difDay=parseInt(dif/cDay);
	 
	 if(checkIn===""){
		 alert("체크인 날짜를 입력하세요"); 
		 document.getElementById("checkOut").value="";
	 }else if(checkIn>=checkOut){
		 alert("잘못된 날짜입니다. 다시 선택하세요");
		 document.getElementById("checkOut").value="";
	 }else if(difDay>=5){
		 alert("5일 이상 숙박할 수 없습니다.");
		 document.getElementById("checkOut").value="";
	 }
	 
}

function inputCheckIn(){
	 var now = new Date();
	 year = now.getFullYear();          // 현재 년도 가져오기
	 month = now.getMonth()+1;        // 현재 월 가져오기 (+1)
	 if((month+"").length < 2){         //월이 '1'로 찍히지 않고 '01'로 찍히도록 길이를 받아온다
	      month = "0" +month;         //길이가 1이라면 앞에 0을 붙여서 '01'형태로 나오게 한다
	 }
	date = now.getDate();       // 현재 날짜 가져오기
	 if((date+"").length < 2){         //일이 '7'로 찍히지 않고 '07'로 찍히도록 길이를 받아온다
	  date = "0" +date;           //길이가 1이라면 앞에 0을 붙여서 '07'형태로 나오게 한다
	 }
	 today = year +""+ month +""+ date ;           //오늘 날짜 ex) 20200119
	
	
	 var InputDate = document.getElementById("checkIn").value;    //입력된 날짜 받아오기
	 var dateSplit = InputDate.split("-");         //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split
	
	 year = dateSplit[0];      //첫번째 배열은 년
	 month = dateSplit[1];  //월
	 day = dateSplit[2];   //일

	 InputDate = year +""+ month +""+ day;       //입력된 값을 더해준다.

	 if (parseInt(InputDate) < parseInt(today) ){          //int형으로 변환하여 비교한다
	      alert("오늘 날짜보다 이전 날짜입니다.");
	      document.getElementById("checkIn").value = "";         //이전 날짜라면 입력폼 리셋처리
	 }
	 document.getElementById("checkOut").value="";
}
</script>