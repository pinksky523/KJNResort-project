console.log("mypage Module(js file)......");

var mypageService = (function() {
	
	function modify(modiInfo, callback, error) {
		console.log("mypage modify......");
		
		$.ajax({
			type : 'post',
			url : 'member/mypage/' + id,
			data : JSON.stringify(modiInfo),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, err) {
				if(err) {
					error(err);
				}
			}
		})
	}


return {
	modify : modify
	};



})();		