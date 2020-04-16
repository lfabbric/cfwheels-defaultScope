component extends="wheels.Model" {
	function config(){
		table("orders");
		defaultScope(
            order="orderDate,requiredDate"            
        );
	}
}