console.log("joongBokCheck Module(js file)......");

var idCheckService = (function() {
	   function getId(id, callback, error) {
		   $.get("/check/idCheck/" + id + ".json", function(result){
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
	   
   var phoneCheckService = (function() {
	   function getPhoneNumber(phoneNumber, callback, error) {
		   $.get("/check/phoneCheck/" + phoneNumber + ".json", function(result){
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
		   getPhoneNumber : getPhoneNumber
		  };
})();