(function(_, undefined) {

  function RouterBuilder($routeProvider) {
    new Router($routeProvider).bindRoutes();
  }

  function Router($routeProvider) {
    this.provider = $routeProvider;
  }

  var fn = Router.prototype;

  fn.directRoutes = ['/', '/convidados', '/convites/:code/card', '/login'];
  fn.customRoutes = {
    '/convites/:code': { controller: 'InviteController', controllerAs: 'ic' },
    '/padrinhos': { controller: 'InviteController', controllerAs: 'ic' }
  };

  fn.bindRoutes = function() {
    var router = this;

    _.each(router.directRoutes, function(route) {
      router.provider.when(route, {
        templateUrl: router.buildTemplateFor(route)
      });
    });

    _.each(router.customRoutes, function(params, route) {
      _.extend(params, {
        templateUrl: router.buildTemplateFor(route)
      });

      router.provider.when(route, params);
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
