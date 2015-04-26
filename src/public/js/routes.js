// definition of application routes
define(['ember', 'app', 'models'], function(Ember, App) {

  App.ApplicationRoute = Ember.Route.extend({
    model: function() {
      return App.DatabaseModel.create();
    }
  });

  App.IndexRoute = Ember.Route.extend({
    model: function() {
      return App.ScriptsModel.create();
    },
    setupController: function() {

    }
  });

  App.ScriptsRoute = Ember.Route.extend({
    model: function() { 
      return [];
    },

    serialize: function(model) {
      return { database: 'test'};
    }
  });

});