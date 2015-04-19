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

});