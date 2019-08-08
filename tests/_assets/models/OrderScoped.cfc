component extends="app.models.model" {
	function config(){
		table("orders");
		defaultScope(
            order="orderDate,requiredDate"            
        );
	}
}