(:
Copyright 2012 MarkLogic Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
:)
xquery version "1.0-ml";

import module namespace c = "http://marklogic.com/roxy/config" at "/app/config/config.xqy";

import module namespace vh = "http://marklogic.com/roxy/view-helper" at "/roxy/lib/view-helper.xqy";

import module namespace facet = "http://marklogic.com/roxy/facet-lib" at "/app/views/helpers/facet-lib.xqy";

declare namespace search = "http://marklogic.com/appservices/search";

declare option xdmp:mapping "false";

<div xmlns="http://www.w3.org/1999/xhtml" id="content" ng-controller="ScriptsController">

  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <span class="navbar-brand">Scripts</span>
      </div>
      <div class="collapse navbar-collapse">
        <form name="findForm" class="navbar-form navbar-right" ng-submit="findScripts(config)">
          <div class="form-group">
            <label for="content-db">Content</label>
            <select id="content-db" name="content-db" class="form-control" ng-model="config.contentDb">
            {
              for $db in vh:get('content-databases')
              return <option value="{$db}">{ $db }</option>
            }
            </select>
          </div>
          <div class="form-group">
            <label for="modules-db">Modules</label>
            <select id="modules-db" name="modules-db" class="form-control" ng-model="config.modulesDb">
            {
              for $db in vh:get('module-databases')
              return <option value="{$db}">{ $db }</option>
            }
            </select>
          </div>
          <div class="form-group">
            <label for="scripts-dir">Directory</label>
            <input id="scripts-dir" name="scripts-dir" type="text" placeholder="/scripts/" class="form-control" ng-model="config.scriptsDir" />
          </div>
          <button type="submit" class="btn btn-default">Search</button>
        </form>
      </div>
    </div>
  </nav>
    
  <div>
    <table id="scriptTable" class="table table-bordered table-hover">
      <tr>
        <th>Script</th>
        <th>Description</th>
        <th></th>
      </tr>
      <tr ng-repeat="script in allScripts | orderBy:'script'">
        <td>[[ script.script ]]</td>
        <td>[[ script.description ]]</td>
        <td class="run-col"><button type="submit" class="btn btn-success btn-sm" ng-model="script" ng-click="run(config, script)">Run</button></td>
      </tr>      
    </table>
  </div>
  
</div>


(:
{
  let $scripts := vh:get("scripts")
  return 
    if (fn:count($scripts) gt 0) then
      for $script in $scripts
      return 
        <tr>
          <td>{ $script }</td>
          <td>does something</td>
          <td class="run-col"><button type="submit" class="btn btn-success btn-sm">Run</button></td>
        </tr>
    else 
      <tr>
        <td colspan="3">no scripts found!</td>
      </tr>
}
:)