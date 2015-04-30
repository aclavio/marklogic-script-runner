// setup the ember application
define(['ember', 'templates'], function(Ember) {
  var EmberApp = Ember.Application.extend({rootElement: '#content'});

  return EmberApp.create({
    LOG_TRANSITIONS: true
  });
});