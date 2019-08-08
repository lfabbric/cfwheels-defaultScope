# Plugin: Default Scope

## Description

The main purpose of the Default Scope plugin is to provide a solution to set the default scope for your findAll() method.  For example, a model can be configured to predefine the fields to select when calling the findAll() method.

You can specify the default values for the following attributes:
 - where
 - order
 - group
 - select
 - distinct
 - include
 - maxRows
 - page
 - perPage
 - count
 - handle
 - cache
 - reload
 - parameterize
 - returnAs
 - returnIncluded
 - callbacks
 - includeSoftDeletes

This Plugin is an adaptation of the original CFWheels DefaultScope plugin created by Joshua Clingenpeel - https://github.com/illuminerdi/DefaultScope

## Requirements
Coldfusion
 - Lucee 5
 - Adobe Coldfusion 2016

## Usage

### Model Setup
#### Basic model setup
```java
component extends="Model" {
    function config(){
        table("tableName");
        defaultScope(
            select="title, description, author, publisheddate"
        );
    }
}
```

#### Appending defaultScope attributes
```java
component extends="Model" {
	function config(){
        table("tableName");
        defaultScope(
            select="title, description, author, publisheddate"
        );
        defaultScope(
            select="category"
        );
    }
}
```

### Controller Usage
```java
component extends="app.models.model" {
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
    }
}

// will in turn call model("order").findAll()
model("order").findAll(exclusive=true);

// will in turn call model("order").findAll(order="orderDate,requiredDate", select="orderNumber,status,comments,customerNumber", maxRows=10);
model("order").findAll();

// will in turn call model("order").findAll(order="orderDate,requiredDate", select="orderNumber,status,comments,customerNumber", maxRows=5);
model("order").findAll(maxRows=5);
model("order").findAll(maxRows=5, inclusive=false);

// will in turn call model("order").findAll(order="orderDate,requiredDate", select="orderNumber,status,comments,customerNumber", maxRows=10);
model("order").findAll(maxRows=5, inclusive=true);

// will in turn call model("order").findAll(order="orderDate,requiredDate", select="amount,orderNumber,status,comments,customerNumber", maxRows=10);
model("order").findAll(select="amount", inclusive=true);
```

#### Parameters - findAll()
Parameter | Type | Required | Default | Description
--- | --- | --- | --- | ---
exclusive | `boolean` | false | false | toggles defaultScope on or off - when true, default functionality found in CFWheels findAll() will work as expected
inclusive | `boolean` | false | false | when set to true, inclusive will append the values found in the findAll() with the values defined in the default scope. When set to false, the values defined in the findAll() will replace the values defined in the default scope.

---

