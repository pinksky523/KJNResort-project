console.log("Reply Module......");

var replyService = (function(){ 
	
	function getList(param, callback, error){			//댓글 목록
		var url = "/replies/pages/" + param.bno + "/" + param.page + ".json";
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
	
	
	
	return { getList : getList };
})();











