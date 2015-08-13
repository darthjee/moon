(function(_) {

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
     return function() {
       return route + '?ajax=true';
     };
  };

  var app = angular.module('moon');

  app.config(['$routeProvider', RouterBuilder]);
})(window._);
