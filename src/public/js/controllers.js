// definition of application controllers
define(['ember', 'app', 'jquery', 'models'], function(Ember, App, $) {

  App.ApplicationController = Ember.ObjectController.extend({
    currentDb: null,
    scripts: null,

    initialize: function() {
      console.log('initializing ApplicationController');
    }.on("init"),

    /*
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
    */
    actions: {
      setDatabase: function() {
        var db = $('#databaseSelect').val();
        this.set('currentDb', db);
        //this.scriptSearch(db);
      }
    }
  });

  App.IndexController = Ember.ObjectController.extend({
    needs: 'application',
    app: Ember.computed.alias('controllers.application'),

    initialize: function() {
      console.log('initializing IndexController');
    }.on("init"),

    findScripts: function() {
      var db = this.get('app.currentDb');
      var model = this.get('model');
      console.log('searching for scripts in:', db);
      model.findScripts(db);
    }.observes('app.currentDb'),

    actions: {
      executeScript: function() {
        console.log("not yet implemented!");
      }
    }
  });

});