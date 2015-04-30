xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/controller/scripts";

import module namespace ch  = "http://marklogic.com/roxy/controller-helper" at "/roxy/lib/controller-helper.xqy";
import module namespace req = "http://marklogic.com/roxy/request" at "/roxy/lib/request.xqy";
import module namespace m   = "http://marklogic.com/roxy/models/scripts" at "/app/models/scripts-lib.xqy";

declare option xdmp:mapping "false";

(:
declare function c:main() as item()*
{
  let $dbs := m:get-databases()
  let $scripts := m:find-scripts("sof-sdl-modules", "/app/")

  return
  (
    ch:add-value("content-databases", $dbs),
    ch:add-value("module-databases", $dbs),
    ch:add-value("scripts", $scripts)
  )
};
:)

declare function c:get-databases() {
  let $dbs := json:to-array(m:get-databases())
  return (
    xdmp:set-response-code(200, "success"),
    xdmp:to-json($dbs)
  )
};

declare function c:find-script()
{
  let $db-name := req:required("db-name", "type=xs:string")
  let $script-name := req:required("script-name", "type=xs:string")
  let $script := m:find-script($db-name, $script-name)

  return (
    xdmp:set-response-code(200, "success"),
    xdmp:to-json($script)   
  )
};

declare function c:find-scripts()
{
  let $db-name := req:required("db-name", "type=xs:string")
  let $scripts := m:find-scripts($db-name)

  return (
    xdmp:set-response-code(200, "success"),
    xdmp:to-json($scripts)   
  )
};

declare function c:find-scripts-legacy()
{
  (: query params :)
  let $modules-db := req:required("modules-db", "type=xs:string")
  let $scripts-dir := req:get("scripts-dir", "/", "type=xs:string")

  let $scripts := m:find-scripts-legacy($modules-db, $scripts-dir)
  let $scripts-maps :=
    for $s in $scripts
      let $m := map:map()
      let $_ := (
        map:put($m, 'script', $s),
        map:put($m, 'description', 'no description')
      )
      return $m

  return (
    xdmp:set-response-code(200, "success"),
    if (fn:exists($scripts-maps)) then
      if (fn:count($scripts-maps) gt 1) then
        xdmp:to-json($scripts-maps)
      else
        let $arr := json:array()
        let $_ := json:array-push($arr, $scripts-maps)
        return xdmp:to-json($arr)
    else
      xdmp:to-json(json:array())    
  )
};

declare function c:run-script() {
  let $db-name := req:required("db-name", "type=xs:string")
  let $script-name := req:required("script-name", "type=xs:string")
  let $script := m:find-script($db-name, $script-name)

  return (
    if ($script) then (
      xdmp:set-response-code(200, "success"),
      m:run-script($script)
    ) else (
      xdmp:set-response-code(404, "script not found"),
      "script not found"
    )
  )
};

(:
declare function c:run-legacy()
{
  let $content-db := req:required("content-db", "type=xs:string")
  let $modules-db := req:required("modules-db", "type=xs:string")
  let $script := req:required("script", "type=xs:string")

  let $log := xdmp:log(text{'Running script:', $script, '[', $content-db, '(', $modules-db, ')]'}, "debug")
  let $result := m:run-script($script, $content-db, $modules-db)

  return (
    ch:set-format("text"),
    xdmp:quote($result)
  )
};
:)
