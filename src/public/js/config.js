requirejs.config({
  baseUrl: '/js',
  shim:{
    handlebars:{
      exports: 'Handlebars',
      init: function(){window.Handlebars=Handlebars}
    },
    jquery: {
      exports: '$'
    },
    ember: {
      deps: ['handlebars', 'jquery'],
      exports: 'Ember'
    }
  },
  noGlobal: true,
  paths:{
    //app:"workspace_app/app",
    ember: 'lib/ember-1.8.1',
    jquery: 'lib/jquery-1.11.2.min',
    handlebars: 'lib/handlebars-v1.3.0',
    text: 'lib/text'
  }
});

require(['ember', 'app', 'routes', 'controllers', 'templates'], function(Ember, App) {

  //var EmberApp = Ember.Application.extend({rootElement: '#content'});

  //window.App = Ember.Application.create({
  //window.App = EmberApp.create({
  //  LOG_TRANSITIONS: true
  //});

  App.Router.reopen({
    rootURL: '/ui/'
  });

  App.Router.map(function(){
    this.resource('scripts', {path: '/scripts/:database'});
  });

});

/*
var scriptsApp = angular.module('scriptsApp', []);

scriptsApp.config(function($interpolateProvider){
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
});

scriptsApp.controller('ScriptsController', function($scope, $http){
  $scope.empty = { script: "--", description: "--" };
  $scope.allScripts = [$scope.empty];
  
  $scope.findScripts = function($config) {
    console.log("loading scripts: ", $config);
    $http({
      method: 'GET',
      url: '/scripts/find',
      params: {
        'modules-db': $config.modulesDb,
        'scripts-dir': $config.scriptsDir
      }
    }).success(function(data, status){
      console.log(status, data);
      $scope.allScripts = data;
    }).error(function(data, status){
      console.error(status, data);
    });

  $scope.run = function($config, $script){
    console.log('run: ', $config, ' ', $script)
    $http({
      method: 'POST',
      url: '/scripts/run',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      data: 
        'content-db=' + $config.contentDb +
        '&modules-db=' + $config.modulesDb +
        '&script=' + $script.script
      
    }).success(function(data, status){
      console.log(status, data);
      // load the results into a new window
      // TODO: view the results in a panel or table in the current page
      var resultsWindow = window.open()
      resultsWindow.document.write(data);
    }).error(function(data, status){
      console.error(status, data);
      // load the error into a new window (helps with debugging)
      var resultsWindow = window.open()
      resultsWindow.document.write(data);
    });
  };

  };

});
*/