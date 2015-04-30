// definition of application models
define(['ember', 'app', 'jquery'], function(Ember, App, $) {

  App.DatabaseModel = Ember.Object.extend({
    databases: Ember.A(),

    init: function() {
      this.getDatabases();
    },

    getDatabases: function() {
      var that = this;
      $.get('/api/database').done(function(resp) {
        that.set('databases', resp.sort());
      }).fail(function(resp) {
        console.error(resp);
        that.set('databases', Ember.A());
      });
    }
  });

  App.ScriptModel = Ember.Object.extend({
    name: null,
    description: null,
    category: null,
    path: null,
    contentDb: null,
    modulesDb: null,
    parameters: []
  });

  App.ScriptsModel = Ember.Object.extend({
    database: null,
    scripts: Ember.A(),
    loading: false,

    findScripts: function(db) {
      var that = this;
      this.set('loading', true);
      this.set('database', db);
      $.get('/api/database/' + db + '/script').done(function(data){
        console.log(data);
        var scripts = that.get('scripts');
        scripts.clear();
        for (i = 0; i < data.length; i++) {
          var script = App.ScriptModel.create(data[i]);
          scripts.pushObject(script);
        }
      }).fail(function(err){
        console.error(err);
        that.get('scripts').clear();
      }).always(function(){
        that.set('loading', false);
      });
    },

    /*
    setScripts: function(db, vals) {
      this.set('database', db);
      this.set('scripts', vals || this.placeholder);
    },
    */

    newScript: function() {

    },

    runScript: function(script) {
      var that = this;
      this.set('loading', true);
      var url = '/api/database/' + this.get('database') + '/script/' + encodeURIComponent(script.name);
      $.post(url)
        .done(function(data){
          var win = window.open('', '_blank');
          win.document.write(data);
        }).fail(function(err){
          console.error('error running script "%s"', script.name, err);
          var win = window.open('', '_blank');
          //win.document.write('<pre>' + err.responseText + '</pre>');
          $(win.document.body).text(err.responseText);
        }).always(function(){
          that.set('loading', false);
        });
    }
  });

});