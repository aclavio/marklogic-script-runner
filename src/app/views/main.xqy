xquery version "1.0-ml";

xdmp:set-response-content-type("text/html"),
xdmp:set-response-encoding("UTF-8"),
"<!DOCTYPE html>",
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>MarkLogic Script Runner</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="/css/app.css" />
  </head>
  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">MarkLogic Script Runner</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">
      <div id="content" class="main-content">
      </div>
    </div>

    <!-- Load our JS here -->
    <script src="/js/lib/jquery-1.11.2.min.js"></script>
    <script src="/js/lib/handlebars-v1.3.0.js"></script>
    <script src="/js/lib/ember-1.8.1.js"></script>
    <script src="/js/lib/bootstrap.min.js"></script>
    <script src="/js/lib/require.js"></script>
    <script src="/js/config.js"></script>
  </body>
</html>