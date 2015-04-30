define(['ember',
  'text!templates/application.hbs',
  'text!templates/index.hbs'
  ], function(Ember,
    applicationTemplate,
    indexTemplate
  ){

  /*
  var basePath = "templates/",
      extention = "hbs",
      templates = [
        'application',
        'index'
      ];

  var loadTemplate = function(name) {
    var path = basePath + name + '.' + extention;
    console.debug('loading template: ' + name, path);

    require(['text!' + path], function(content){
      console.log('content for ' + name, content);
      Ember.TEMPLATES[name] = Ember.Handlebars.compile(content);
    });
  }

  for (var i = 0; i < templates.length; i++) {
    loadTemplate(templates[i]);
  }
  */

  Ember.TEMPLATES['application'] = Ember.Handlebars.compile(applicationTemplate);
  Ember.TEMPLATES['index'] = Ember.Handlebars.compile(indexTemplate);

});