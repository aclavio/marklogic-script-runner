requirejs.config({
  baseUrl: '/js',
  shim:{
    handlebars:{
      exports: 'Handlebars',
      init: function(){window.Handlebars=Handlebars}
    },
    jquery: {
      exports: '$'
    },
    ember: {
      deps: ['handlebars', 'jquery'],
      exports: 'Ember'
    }
  },
  noGlobal: true,
  paths:{
    //app:"workspace_app/app",
    ember: 'lib/ember-1.8.1',
    jquery: 'lib/jquery-1.11.2.min',
    handlebars: 'lib/handlebars-v1.3.0',
    text: 'lib/text'
  }
});

require(['ember', 'app', 'routes', 'controllers', 'views', 'templates'], function(Ember, App) {

  // Override didInsertElement() to trigger event to run
  // DOM-ready dependent code, like jQuery plugins
  Ember.View.reopen({
    didInsertElement: function() {
      this._super();
      Ember.run.scheduleOnce('afterRender', this, this.afterRenderEvent);
    },
    afterRenderEvent: function() {
      // implement this hook in your own Views
    }
  });

  App.Router.reopen({
    rootURL: '/ui/'
  });

  App.Router.map(function(){
    this.resource('scripts', {path: '/scripts/:database'});
  });

});