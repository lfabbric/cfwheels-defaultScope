component extends="wheels.Model" {
	function config(){
		table("payments");
		defaultScope(order="paymentDate");
	}
}