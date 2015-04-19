// definition of application routes
define(['ember', 'app', 'models'], function(Ember, App) {

  App.ApplicationRoute = Ember.Route.extend({
    model: function() {
      return App.DatabaseModel.create();
    }
  });

  App.IndexRoute = Ember.Route.extend({
    setupController: function() {

    }
  });

  App.ScriptsRoute = Ember.Route.extend({
    model: function(parms) {
      console.log("loading scripts for:", params.database);
      return [
          {
            name: 'test1',
            description: 'foo bar'
          },
          {
            name: 'test2',
            description: 'lorum ipsum'
          }
        ]
    },

    serialize: function(model) {
      return { database: 'test'};
    }
  });

});