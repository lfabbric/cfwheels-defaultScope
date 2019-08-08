component extends="app.models.model" {
	function config(){
		table("payments");
		defaultScope(order="paymentDate");
	}
}