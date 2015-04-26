// definition of application models
define(['ember', 'app', 'jquery'], function(Ember, App, $) {

  App.DatabaseModel = Ember.Object.extend({
    databases: [],

    init: function() {
      this.getDatabases();
    },

    getDatabases: function() {
      var that = this;
      $.get('/api/database').done(function(resp) {
        that.set('databases', resp.sort());
      }).fail(function(resp) {
        console.error(resp);
        that.set('databases', []);
      });
    }
  });

  App.ScriptsModel = Ember.Object.extend({
    database: null,
    scripts: [],

    placeholder: [{
      script: '[[ script name ]]',
      description: '[[ description ]]'
    }],

    init: function() {
      this.set('scripts', this.placeholder);
    },

    setScripts: function(db, vals) {
      this.set('database', db);
      this.set('scripts', vals || this.placeholder);
    },

    newScript: function() {

    },

    runScript: function() {

    }
  });

});