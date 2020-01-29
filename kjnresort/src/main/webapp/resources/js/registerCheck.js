console.log("registerCheck Module(js file)......");

var idCheckService = (function() {
	   function getId(id, callback, error) {
		   $.get("/recruit/idCheck/" + id + ".json", function(result){
	         if(callback){
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