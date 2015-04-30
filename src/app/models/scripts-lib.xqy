xquery version "1.0-ml";

module namespace m = "http://marklogic.com/roxy/models/scripts";

import module namespace c     = "http://marklogic.com/roxy/config" at "/app/config/config.xqy";
import module namespace admin = "http://marklogic.com/xdmp/admin"  at "/MarkLogic/admin.xqy";

declare namespace scripts = "http://marklogic.com/script-runner/scripts";

declare option xdmp:mapping "false";

declare variable $config := admin:get-configuration();

declare function m:get-databases() as xs:string*
{
  for $id in admin:get-database-ids($config)
  return admin:database-get-name($config, $id)
};

declare function m:find-script($db-name, $script-name) as element(scripts:script)? 
{
  xdmp:invoke-function(function(){
    let $script := /scripts:scripts/scripts:script[@name eq $script-name]
    return
      if (fn:count($script) eq 0) then
        xdmp:log('No scripts found with name "' || $script-name || '"', "warning")
      else if (fn:count($script) gt 1) then 
        (xdmp:log('Multiple scripts found with name "' || $script-name || '"', "warning"), xdmp:eager($script[1]))
      else
        xdmp:eager($script)
  }, 
  <options xmlns="xdmp:eval">
    <database>{xdmp:database($db-name)}</database>
  </options>
  )
};

declare function m:find-scripts($db-name) as json:array
{
  xdmp:invoke-function(function(){
    let $arr := json:array()
    let $scripts :=
      for $script in /scripts:scripts/scripts:script
        let $obj := json:object()
        let $_ := (
          map:put($obj, "name", fn:string($script/@name)),
          map:put($obj, "category", fn:string($script/@category)),
          map:put($obj, "path", fn:string($script/scripts:path/text())),
          map:put($obj, "description", fn:string($script/scripts:description/text())),
          map:put($obj, "contentDb", fn:string($script/scripts:content-db/text())),
          map:put($obj, "modulesDb", fn:string($script/scripts:modules-db/text()))
        )
        order by $script/@name
        return $obj
    let $_ :=
      (: add them in sorted order :)
      for $script in $scripts
      return json:array-push($arr, $script)
    return $arr
  }, 
  <options xmlns="xdmp:eval">
    <database>{xdmp:database($db-name)}</database>
  </options>
  )
};

declare function m:find-scripts-legacy($modules-db-name, $scripts-dir) as xs:string*
{
  xdmp:invoke-function(function(){
    cts:uri-match($scripts-dir || "*.xqy")
  }, 
  <options xmlns="xdmp:eval">
    <database>{xdmp:database($modules-db-name)}</database>
  </options>
  )
};

declare function m:run-script($script as element(scripts:script)) {
  (: todo: parse out query params :)
  m:run-script($script/scripts:path/text(),
    $script/scripts:content-db/text(),
    $script/scripts:modules-db/text(),
    ())
};

declare function m:run-script($script, $content-db, $modules-db, $params as item()*) {
  xdmp:log(text{'Running script:', $script, '[', $content-db, '(', $modules-db, ')]'}, "debug"),
  xdmp:invoke($script, $params, 
    <options xmlns="xdmp:eval">
      <database>{xdmp:database($content-db)}</database>
      <modules>{xdmp:database($modules-db)}</modules>
      <transaction-mode>auto</transaction-mode>
      <root>/</root>
    </options>
  )
};