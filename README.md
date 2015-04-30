# MarkLogic Script Runner

## Overview
MarkLogic Script Runner is a web application designed to allow users to quickly run server-side MarkLogic scripts without needing to use the qconsole, or have any xquery background.

## Scripts
Scripts are defined via xml configuration files.  These script definition files must be located within a database on the MarkLogic Server where the scripts are to be executed.  Each script definition should have the following form:

```xml
<scripts xmlns="http://marklogic.com/script-runner/scripts">
  <script name="Example" category="Samples">
    <description>This is a sample script description.</description>
    <path>/test/sample-script.xqy</path>
    <content-db>content-db-name</content-db>
    <modules-db>modules-db-name</modules-db>
  </script>
</scripts>
```


