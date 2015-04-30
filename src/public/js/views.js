// definition of application views
require(['ember', 'app', 'jquery'], function(Ember, App, $) {

  App.IndexView = Ember.View.extend({
    afterRenderEvent: function() {
      // active bootstrap tooltips
      $('[data-toggle="tooltip"]').tooltip()
    }
  });

});