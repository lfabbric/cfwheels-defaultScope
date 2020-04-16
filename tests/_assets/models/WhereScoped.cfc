component extends="wheels.Model" {
	function config(){
		table("orders");
		defaultScope(
            where="customernumber IN (129, 131)",
			order="orderDate,requiredDate"
        );
	}
}