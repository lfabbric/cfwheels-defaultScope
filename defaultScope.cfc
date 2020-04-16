component hint="cfwheels defaultScope support" output="false" mixin="global" {
    public function init() {
        this.version = "2.1";
        return this;
    }

    /**
    * exclusive = {boolean} true  = disable defaultScope
    *                       false = enable defaultScope
    * inclusive = {boolean} true  = will merge submitted argument with scope defined in model
    *                       false = will replace submitted argument with scope defined in model
    *
    * @mixin model
    */
    public function findAll(boolean exclusive=false, boolean inclusive=false) {
        if (arguments.exclusive && arguments.inclusive) {
		    throw(
                type="Wheels.invalidFormat",
                message="Both arguments `exclusive` and `inclusive` are mutually exclusive. Both cannot be true in the same request."
            );
        }
        var defaultScope = $getDefaultScope();
        if (arguments.exclusive == false) {
            for (var key in defaultScope) {
                if ($isValidDefaultScopeArgument(key)) {
                    if (arguments.inclusive) {
                        if ($defaultScopeArgumentCanAppend(key) && arguments.keyExists(key)) {
                            switch (key) {
                                case "where":
                                    arguments[key] = "(#defaultScope[key]#) AND (#arguments[key]#)";
                                    break;
                                default:
                                    arguments[key] &= "," & defaultScope[key];
                                    break;
                            }
                        } else {
                            arguments[key] = defaultScope[key];
                        }
                    } else {
                        if (!arguments.keyExists(key)) {
                            arguments[key] = defaultScope[key];
                        }
                    }
                }
            }
        }
        arguments.delete("exclusive");
        arguments.delete("inclusive");
        return core.findAll(argumentCollection=arguments);
    }

    /**
    * Needs to be added in the config() of the Model
    *
    * [section: Plugins]
    * [category: defaultScope]
    *
    * @mixin model
    * @defaultScope="objectName"
    */
    public function defaultScope() {
        if (!variables.wheels.class.keyExists("defaultScope")) {
            variables.wheels.class.defaultScope = {};
        }
        for (var key in arguments) {
            if ($isValidDefaultScopeArgument(key)) {
                if (variables.wheels.class.defaultScope.keyExists(key) && $defaultScopeArgumentCanAppend(key)) {
                    variables.wheels.class.defaultScope[key] &= "," & arguments[key];
                } else {
                    variables.wheels.class.defaultScope[key] = arguments[key];
                }
            }
        }
    }

    public function $getDefaultScope() {
        var defaultScope = {};
        if (variables.wheels.class.keyExists("defaultScope")) {
            defaultScope = variables.wheels.class.defaultScope;
        }
        return defaultScope;
    }

    public function $isValidDefaultScopeArgument(required string scopeName) {
        return (listFindNoCase("where,order,group,select,distinct,include,maxRows,page,perPage,count,handle,cache,reload,parameterize,returnAs,returnIncluded,callbacks,includeSoftDeletes", arguments.scopeName) gt 0);
    }

    public function $defaultScopeArgumentCanAppend(required string scopeName) {
        return (listFindNoCase("where,order,select,include", arguments.scopeName) gt 0);
    }
}