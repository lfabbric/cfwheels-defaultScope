component extends="wheels.Test" {

    function setup() {
        variables.loc = {};
        $previousDataSourceName = get("dataSourceName");
        $baseModelPath = application.wheels.modelPath;
        application.wheels.modelPath = application.wheels.rootPath & application.wheels.pluginPath & "/defaultScope/tests/_assets/models/";
        set(dataSourceName="storetest");
        nonScopedModel = model("NotScoped").new();
    }

    function teardown() {
        application.wheels.modelPath = $baseModelPath;
        set(dataSourceName = $previousDataSourceName);
    }

    // initialization
    function test_initialize_inclusive_and_exclusive_set_true() {
        var hasFailed = false;
        try {
            m = nonScopedModel.findAll(exclusive=true, inclusive=true);
        } catch (any e) {
            hasFailed = true;
        }
        assert("#hasFailed#");
    }

    function test_initialize_inclusive_set_true() {
        var hasFailed = false;
        try {
            m = nonScopedModel.findAll(exclusive=false, inclusive=true);
        } catch (any e) {
            hasFailed = true;
        }
        assert("#!hasFailed#");
    }

    function test_initialize_exclusive_set_true() {
        var hasFailed = false;
        try {
            m = nonScopedModel.findAll(exclusive=true, inclusive=false);
        } catch (any e) {
            hasFailed = true;
        }
        assert("#!hasFailed#");
    }
}