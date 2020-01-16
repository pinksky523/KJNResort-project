console.log("joinform Check Module.......");
var chkService = (function(){	
	
	function idchk(rno, replyer, callback, error){
		$.ajax({
			url: '/replies/' + rno,
			type: 'delete',
			data: JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, err){
				if(err){
					error(err);
				}
			}
		})//END ajax()
	}//ENG idchk()
	
	
	
	return {
		idchk : idchk,
		};
	
//	return {name: "aaaaa"};
})();