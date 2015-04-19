// definition of application routes
define(['ember'], function(Ember) {
  var EmberApp = Ember.Application.extend({rootElement: '#content'});

  return EmberApp.create({
    LOG_TRANSITIONS: true
  });
});