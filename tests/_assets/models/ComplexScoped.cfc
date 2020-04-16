component extends="wheels.Model" {
	function config(){
		table("orders");
		defaultScope(
            order="orderDate,requiredDate",
            select="orderNumber, status, comments",
            maxRows=10
        );
        defaultScope(
            select="customerNumber"
        );
        defaultScope(
            maxRows=4
        );
	}
}