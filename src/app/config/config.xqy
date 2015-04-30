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

module namespace c = "http://marklogic.com/roxy/config";

import module namespace def = "http://marklogic.com/roxy/defaults" at "/roxy/config/defaults.xqy";

declare namespace rest = "http://marklogic.com/appservices/rest";

(:
 : ***********************************************
 : Overrides for the Default Roxy control options
 :
 : See /roxy/config/defaults.xqy for the complete list of stuff that you can override.
 : Roxy will check this file (config.xqy) first. If no overrides are provided then it will use the defaults.
 :
 : Go to https://github.com/marklogic/roxy/wiki/Overriding-Roxy-Options for more details
 :
 : ***********************************************
 :)
declare variable $c:ROXY-OPTIONS :=
  <options>
    <layouts>
      <layout format="html">application</layout>
    </layouts>
  </options>;

(:
 : ***********************************************
 : Overrides for the Default Roxy scheme
 :
 : See /roxy/config/defaults.xqy for the default routes
 : Roxy will check this file (config.xqy) first. If no overrides are provided then it will use the defaults.
 :
 : Go to https://github.com/marklogic/roxy/wiki/Roxy-URL-Rewriting for more details
 :
 : ***********************************************
 :)
declare variable $c:ROXY-ROUTES :=
  <routes xmlns="http://marklogic.com/appservices/rest">
    
    <!-- API endpoints -->
    <request uri="^/api/database(/)?$" endpoint="/roxy/query-router.xqy">
      <http method="GET"/>
      <uri-param name="controller">scripts</uri-param>
      <uri-param name="func">get-databases</uri-param>
      <uri-param name="format">json</uri-param>
    </request>

    <request uri="^/api/database/([%25\-\w\._!'\*\(\)]+)/script[/]?$" endpoint="/roxy/query-router.xqy">
      <http method="GET"/>
      <uri-param name="controller">scripts</uri-param>
      <uri-param name="func">find-scripts</uri-param>
      <uri-param name="format">json</uri-param>
      <uri-param name="db-name">$1</uri-param>
    </request>

    <request uri="^/api/database/([%25\-\w\._!'\*\(\)]+)/script/([%25\-\w\._!'\*\(\)]+)[/]?$" endpoint="/roxy/query-router.xqy">
      <http method="GET"/>
      <uri-param name="controller">scripts</uri-param>
      <uri-param name="func">find-script</uri-param>
      <uri-param name="format">json</uri-param>
      <uri-param name="db-name">$1</uri-param>
      <uri-param name="script-name">$2</uri-param>
    </request>

    <request uri="^/api/database/([%25\-\w\._!'\*\(\)]+)/script/([%25\-\w\._!'\*\(\)]+)[/]?$" endpoint="/roxy/query-router.xqy">
      <http method="POST"/>
      <uri-param name="controller">scripts</uri-param>
      <uri-param name="func">run-script</uri-param>
      <uri-param name="format">html</uri-param>
      <uri-param name="db-name">$1</uri-param>
      <uri-param name="script-name">$2</uri-param>
    </request>
    
    <!-- UI Code passthru -->
    <request uri="^/ui(/|.*)?" endpoint="/app/views/main.xqy" />
    <request uri="^/unauthorized[/]?$" endpoint="/app/views/401.xqy" />
    {
      $def:ROXY-ROUTES/rest:request
    }
  </routes>;

(:
 : ***********************************************
 : A decent place to put your appservices search config
 : and various other search options.
 : The examples below are used by the appbuilder style
 : default application.
 : ***********************************************
 :)
declare variable $c:DEFAULT-PAGE-LENGTH as xs:int := 5;

declare variable $c:SEARCH-OPTIONS :=
  <options xmlns="http://marklogic.com/appservices/search">
    <search-option>unfiltered</search-option>
    <term>
      <term-option>case-insensitive</term-option>
    </term>
    <constraint name="facet1">
      <collection>
        <facet-option>limit=10</facet-option>
      </collection>
    </constraint>

    <return-results>true</return-results>
    <return-query>true</return-query>
  </options>;

(:
 : Labels are used by appbuilder faceting code to provide internationalization
 :)
declare variable $c:LABELS :=
  <labels xmlns="http://marklogic.com/xqutils/labels">
    <label key="facet1">
      <value xml:lang="en">Sample Facet</value>
    </label>
  </labels>;