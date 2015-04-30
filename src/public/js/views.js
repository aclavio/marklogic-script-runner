// definition of application views
require(['ember', 'app', 'jquery', 'bootstrap'], function(Ember, App, $) {

  App.IndexView = Ember.View.extend({
    templateName: 'index',
    afterRenderEvent: function() {
      // active bootstrap tooltips
      console.log('afterRenderEvent!!!!');
      $('[data-toggle="tooltip"]').tooltip();
    }
  });

  App.ScriptTableRowView = Ember.View.extend({
    templateName: 'script-row-table',
    tagName: 'tr',
    afterRenderEvent: function() {
      // active bootstrap tooltips
      var element = this.get('element');
      var script = this.get('controller.model');
      $(element).find('[data-toggle="tooltip"]').tooltip({
        title: script.get('name') + '<br/>' + script.get('contentDb') + '<br/>' + script.get('modulesDb'),
        html: true
      });
    },
    willDestroyElement: function() {
      this._super();
      // tear down tooltips
      var element = this.get('element');
      $(element).find('[data-toggle="tooltip"]').tooltip('destroy');
    }

  });

});