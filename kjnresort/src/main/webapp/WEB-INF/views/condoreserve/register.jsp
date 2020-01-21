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
			beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(roomList){
			
					console.log(roomList);
				
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
	 var today=new Date();
	 var checkIn = document.getElementById("checkIn").value; 
	 var checkOut = document.getElementById("checkOut").value;
   
		
	var dateSplit = checkOut.split("-"); //입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split

	var outYear = dateSplit[0]; //첫번째 배열은 년
	var outMonth = dateSplit[1]; //월
	var outDay = dateSplit[2]; //일
	 
	 
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
	 if(difDay>=5){
		 alert("5일 이상 숙박할 수 없습니다.");
		 document.getElementById("checkOut").value="";
		 return;
	 }
	 
}

	function inputCheckIn() {
		
		
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