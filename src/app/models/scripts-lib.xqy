xquery version "1.0-ml";

module namespace m = "http://marklogic.com/roxy/models/scripts";

import module namespace c = "http://marklogic.com/roxy/config" at "/app/config/config.xqy";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare option xdmp:mapping "false";

declare variable $config := admin:get-configuration();

declare function m:get-databases() as xs:string*
{
  for $id in admin:get-database-ids($config)
  return admin:database-get-name($config, $id)
};

declare function m:find-scripts($modules-db-name, $scripts-dir) as xs:string*
{
  xdmp:invoke-function(function(){
    cts:uri-match($scripts-dir || "*.xqy")
  }, 
  <options xmlns="xdmp:eval">
    <database>{xdmp:database($modules-db-name)}</database>
  </options>
  )
};

declare function m:run-script($script, $content-db, $modules-db)
{
  xdmp:invoke($script, 
    (), 
    <options xmlns="xdmp:eval">
      <database>{xdmp:database($content-db)}</database>
      <modules>{xdmp:database($modules-db)}</modules>
      <root>/</root>
    </options>
  )
};


