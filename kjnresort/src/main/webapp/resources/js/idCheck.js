console.log("idCheck Module(js file)......");

var idCheckService = (function() {
	   function getId(id, callback, error) {
		   $.get("/idCheck/" + id + ".json", function(result){
	    	  console.log("getId -> $.get 진입");
	         if(callback){
	        	console.log("callback 넘기기전 result 값 : " + result);
	            callback(result);
	         }
	      }).fail(function(xhr, status, err){
	         if(error){
	            error();
	         }
	      });
	   }
	   
	   return {
		   getId : getId
		  };
})();