// definition of application controllers
define(['ember', 'app', 'jquery', 'models'], function(Ember, App, $) {

  App.ApplicationController = Ember.ObjectController.extend({
    currentDb: null,
    scripts: null,

    initialize: function() {
      console.log('initializing ApplicationController');
    }.on("init"),

    scriptSearch: function(db) {      
      console.log('searching for scripts in:', db);
      var that = this;
      $.get('/api/database/' + db + '/script').done(function(resp){
        console.log('scripts: ', resp);
        that.set('scripts', App.ScriptsModel.create({
          scripts: resp
        }));
      }).fail(function(resp){
        console.error(resp);
      });
    },

    actions: {
      setDatabase: function() {
        var db = $('#databaseSelect').val();
        this.set('currentDb', db);
        this.scriptSearch(db);
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