component extends="wheels.Test" {

    function setup() {
        variables.loc = {};
        $previousDataSourceName = get("dataSourceName");
        $baseModelPath = application.wheels.modelPath;
        application.wheels.modelPath = application.wheels.rootPath & application.wheels.pluginPath & "/defaultScope/tests/_assets/models/";
        set(dataSourceName="store");
        paymentsNotScopedModel = model("PaymentNotScoped").new();
        paymentsOrderScopedModel = model("PaymentOrderScoped").new();
    }

    function teardown() {
        application.wheels.modelPath = $baseModelPath;
        set(dataSourceName = $previousDataSourceName);
    }

    function test_sum_statistics_scoped() {
        m = paymentsNotScopedModel.sum("amount");
        m2 = paymentsOrderScopedModel.sum("amount");
        assert("m2 eq m");
    }

    function test_maximum_statistics_scoped() {
        m = paymentsNotScopedModel.maximum("amount");
        m2 = paymentsOrderScopedModel.maximum("amount");
        assert("m2 eq m");
    }

    function test_minimum_statistics_scoped() {
        m = paymentsNotScopedModel.minimum("amount");
        m2 = paymentsOrderScopedModel.minimum("amount");
        assert("m2 eq m");
    }

    function test_average_statistics_scoped() {
        m = paymentsNotScopedModel.average("amount");
        m2 = paymentsOrderScopedModel.average("amount");
        assert("m2 eq m");
    }

    function test_count_statistics_scoped() {
        m = paymentsNotScopedModel.count("amount");
        m2 = paymentsOrderScopedModel.count("amount");
        assert("m2 eq m");
    }


}