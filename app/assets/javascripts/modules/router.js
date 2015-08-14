(function(_, undefined) {

  function RouterBuilder($routeProvider) {
    new Router($routeProvider).bindRoutes();
  }

  function Router($routeProvider) {
    this.provider = $routeProvider;
  }

  var fn = Router.prototype;

  fn.routes = ['/', '/convidados', '/convites/:code'];

  fn.bindRoutes = function() {
    var router = this;

    _.each(router.routes, function(route) {
      router.provider.when(route, {
        templateUrl: router.buildTemplateFor(route)
      });
    });
  };

  fn.buildTemplateFor = function(route) {
     return function(params) {
       if (params !== undefined) {
         for(key in params) {
           regexp = new RegExp(':' + key + '\\b');
           route = route.replace(regexp, params[key]);
         }
       }
       return route + '?ajax=true';
     };
  };

  var app = angular.module('moon');

  app.config(['$routeProvider', RouterBuilder]);
})(window._);
