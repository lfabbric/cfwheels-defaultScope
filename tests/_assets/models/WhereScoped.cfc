component extends="app.models.model" {
	function config(){
		table("orders");
		defaultScope(
            where="customernumber IN (129, 131)",
			order="orderDate,requiredDate"
        );
	}
}