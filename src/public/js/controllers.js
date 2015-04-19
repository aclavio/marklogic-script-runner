// definition of application controllers
define(['ember', 'app', 'jquery'], function(Ember, App, $) {

  App.ApplicationController = Ember.ObjectController.extend({
    currentDb: '',

    initialize: function() {
      console.log('initializing ApplicationController');
    }.on("init"),

    actions: {
      scriptSearch: function() {
        console.log('selected:', $('#databaseSelect').val());
        console.log("not yet implemented!");
      }
    }
  });

  App.IndexController = Ember.ArrayController.extend({
    needs: 'application',

    initialize: function() {
      console.log('initializing IndexController');
    }.observes("init"),

    actions: {
      executeScript: function() {
        console.log("not yet implemented!");
      }
    }
  });

});