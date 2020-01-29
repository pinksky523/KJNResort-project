console.log("Reply Module......");

var replyService = (function(){ 
	
	function getList(param, callback, error){			//댓글 목록
		var url = "/replies/pages/" + param.reviewNo + "/" + param.page + ".json";
		
		$.getJSON(url, function(result){
			if(callback) {
			//	callback(result);
				callback(result.replyCnt, result.list);
			}
		}).fail(function(xhr, status, err){
			if(error)	{
				error(err);
			}
		});
	}//END getList()
	
	function add(reply, callback){						//댓글 추가
		console.log("reply add....");
		$.ajax({
			type 	: 'post', 
			url 	: '/replies/new',
			data	: JSON.stringify(reply),
			contentType	: 'application/json; charset=utf-8',
			success	: function(result, status, xhr){
				callback(result);
			},
			error	: function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		})//END ajax()
	}//END add()
	
	function remove(replyNo, id, callback, error){		//댓글 삭제
		console.log("reply remove....");
		$.ajax({
			type 	: 'delete', 
			url 	: '/replies/' + replyNo,
			data	: JSON.stringify({replyNo:replyNo, id:id}),
			contentType	: 'application/json; charset=utf-8',
			success	: function(result, status, xhr){
				callback(result);
			},
			error	: function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});//END ajax()
	}//END remove()
	
	function update(reply, callback, error){			//댓글 수정
		console.log("reply update....");
		$.ajax({
			type 	: 'put', 
			url 	: '/replies/' + reply.replyNo,
			data	: JSON.stringify(reply),
			contentType	: 'application/json; charset=utf-8',
			success	: function(result, status, xhr){
				callback(result);
			},
			error	: function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		})//END ajax()
	}//END update()

	function get(replyNo, callback, error){			//댓글 조회
		var url = "/replies/" + replyNo + ".json";
		$.getJSON(url, function(result){
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error)	{
				error(err);
			}
		});
	}//END get()
	
	//댓글 시간 표시
	function displayTime(timeValue){
		var today 	= new Date();
		var replyDate = new Date(timeValue);
		if(today.getDate() === replyDate.getDate()){	//오늘 작성한 댓글
			var hh = replyDate.getHours();
			var mi = replyDate.getMinutes();
			var ss = replyDate.getSeconds();
			return [ (hh > 9 ? '' : '0' ) + hh, ':', 	//시:분:초 출력
					 (mi > 9 ? '' : '0' ) + mi, ':', 
					 (ss > 9 ? '' : '0' ) + ss ].join('');
		} else {	//오늘 이전 작성한 댓글은 연/월/일 출력
			var yy = replyDate.getFullYear();
			var mm = replyDate.getMonth() + 1;
			var dd = replyDate.getDate();
			return [ yy, '/' , (mm > 9 ? '' : '0') + mm, '/', 
				     (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	return { displayTime : displayTime,
			 get : get,
			 update : update,
			 remove : remove, 
			 getList : getList,
		     add : add };
})();











