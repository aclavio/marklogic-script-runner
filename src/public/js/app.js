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
      data: {
        'content-db': $config.contentDb,
        'modules-db': $config.modulesDb,
        'script': $script
      }
    }).success(function(data, status){
      console.log(status, data);
    }).error(function(data, status){
      console.error(status, data);
    });
  };

  };

});
