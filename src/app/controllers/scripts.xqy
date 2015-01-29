xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/controller/scripts";

(: the controller helper library provides methods to control which view and template get rendered :)
import module namespace ch = "http://marklogic.com/roxy/controller-helper" at "/roxy/lib/controller-helper.xqy";

(: The request library provides awesome helper methods to abstract get-request-field :)
import module namespace req = "http://marklogic.com/roxy/request" at "/roxy/lib/request.xqy";

import module namespace m = "http://marklogic.com/roxy/models/scripts" at "/app/models/scripts-lib.xqy";

declare option xdmp:mapping "false";

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

declare function c:find()
{
  (: query params :)
  let $modules-db := req:required("modules-db", "type=xs:string")
  let $scripts-dir := req:get("scripts-dir", "/", "type=xs:string")

  let $scripts := m:find-scripts($modules-db, $scripts-dir)
  let $scripts-json :=
    for $s in $scripts
      let $m := map:map()
      let $_ := (
        map:put($m, 'script', $s),
        map:put($m, 'description', 'no description')
      )
      return $m

  return (
    ch:set-format("text"),
    xdmp:to-json($scripts-json)
  )
};

declare function c:run()
{
  (: query params :)
  let $content-db := req:required("content-db", "type=xs:string")
  let $modules-db := req:required("modules-db", "type=xs:string")
  let $script := req:required("script", "type=xs:string")

  let $result := m:run-script($script, $content-db, $modules-db)

  return (
    ch:set-format("text"),
    xdmp:quote($result)
  )
};

