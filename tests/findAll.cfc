component extends="wheels.Test" {

    function setup() {
        variables.loc = {};
        $previousDataSourceName = get("dataSourceName");
        $baseModelPath = application.wheels.modelPath;
        application.wheels.modelPath = application.wheels.rootPath & application.wheels.pluginPath & "/defaultScope/tests/_assets/models/";
        set(dataSourceName = "storetest");
        nonScopedModel = model("NotScoped").new();
        complexScopeModel = model("ComplexScoped").new();
        simpleModel = model("OrderScoped").new();
        whereScopeModel = model("WhereScoped").new();
    }

    function teardown() {
        application.wheels.modelPath = $baseModelPath;
        set(dataSourceName = $previousDataSourceName);
    }

    function test_inclusive_with_empty_where() {
        m = whereScopeModel.findAll(inclusive=true);
        assert("m.recordCount eq 7");
    }

    function test_inclusive_with_where() {
        m = whereScopeModel.findAll(inclusive=true, where="status = 'Shipped'");
        assert("m.recordCount eq 6");
    }

    function test_inclusive_false_with_where() {
        m = whereScopeModel.findAll(inclusive=false, where="status = 'Shipped' AND customernumber IN (141,121)");
        assert("m.recordCount eq 26");
    }

    function test_inclusive_overload_scope() { 
        m = complexScopeModel.findAll(maxRows=5, inclusive=true);
        assert("m.recordCount eq 4");
    }

    function test_inclusive_false_overload_scope() { 
        m = complexScopeModel.findAll(maxRows=5, inclusive=false);
        assert("m.recordCount eq 5");
    }
    function test_exclusive_scope() {
        m = complexScopeModel.findAll(maxRows=5, exclusive=true);
        assert("m.recordCount eq 5");
    }

    function test_exclusive_false_scope() {
        m = complexScopeModel.findAll(maxRows=5, exclusive=false);
        assert("m.recordCount eq 5");
    }

    function test_exclusive_scope_not_defind() {
        m = complexScopeModel.findAll(maxRows=5);
        assert("m.recordCount eq 5");
    }

    function test_inclusive_with_additional_select_scope() {
        m = complexScopeModel.findAll(select="orderDate", inclusive=true);
        expectedColumns = ["ORDERNUMBER", "STATUS", "COMMENTS", "CUSTOMERNUMBER", "ORDERDATE"];
        foundColumns = expectedColumns.duplicate();
        for (var key in m.columnList) {
            if (arrayContainsNoCase(expectedColumns, ucase(key))) {
                arrayDelete(foundColumns, key);
            }
        }
        assert("!foundColumns.len()");
    }

    function test_exclusive_with_additional_select_scope() {
        m = complexScopeModel.findAll(select="orderDate", exclusive=true);
        expectedColumns = ["ORDERDATE"];
        foundColumns = expectedColumns.duplicate();
        assert("m.columnList eq 'ORDERDATE'");
        for (var key in m.columnList) {
            if (arrayContainsNoCase(expectedColumns, ucase(key))) {
                arrayDelete(foundColumns, key);
            }
        }
        assert("!foundColumns.len()");
    }

    function test_stacking_scope() {
        m = complexScopeModel.findAll();
        expectedColumns = ["ORDERNUMBER", "STATUS", "COMMENTS", "CUSTOMERNUMBER"];
        foundColumns = expectedColumns.duplicate();
        for (var key in m.columnList) {
            if (arrayContainsNoCase(expectedColumns, ucase(key))) {
                arrayDelete(foundColumns, key);
            }
        }
        assert("!foundColumns.len()");
    }

    function test_non_default_scope_arguments() {
        m = simpleModel.findAll(select="customerNumber");
        expectedresult = "CUSTOMERNUMBER";
        assert("m.columnList eq expectedresult");
    }

    function test_max_rows() {
        rowCount = nonScopedModel.findAll();
        maxRows = complexScopeModel.findAll();
        assert("rowCount.recordCount gt maxRows.recordCount");
        assert("maxRows.recordCount eq 4");
    }

}