(function(_, angular, undefined) {

  function RouterBuilder($routeProvider) {
    new Router($routeProvider).bindRoutes();
  }

  function Router($routeProvider) {
    this.provider = $routeProvider;
  }

  var fn = Router.prototype;

  fn.directRoutes = ['/', '/convidados', '/convites/:code/card', '/login'];
  fn.customRoutes = {
    '/presentes': { controller: 'GiftsListController', controllerAs: 'glc' },
    '/presentes/pagina/:page': { controller: 'GiftsListController', controllerAs: 'glc' },
    '/convites/:code': { controller: 'InviteController', controllerAs: 'ic' },
    '/padrinhos/informativo': { controller: 'BestManController', controllerAs: 'bmc' },
    '/login': { controller: 'LoginController', controllerAs: 'lc' },
    '/login?redirect_to=:redirect_to': { controller: 'LoginController', controllerAs: 'lc' },
    '/presentes/:gift_id/descricao/:id': { controller: 'GiftLinkShowController', controllerAs: 'gsc' },
    '/presentes/:id': { controller: 'GiftShowController', controllerAs: 'gsc' },
    '/senha/recuperar': { controller: 'PasswordRecoveryController', controllerAs: 'prc' },
    '/senha/:code': { controller: 'PasswordEditController', controllerAs: 'pc' },
    '/album/:album_id/fotos': { controller: 'PicturesListController', controllerAs: 'pc' },
    '/album/:album_id/fotos/pagina/:page': { controller: 'PicturesListController', controllerAs: 'pc' },
    '/album': { controller: 'AlbumsListController', controllerAs: 'ac' },
    '/album/pagina/:page': { controller: 'AlbumsListController', controllerAs: 'ac' },
    '/admin/login': { controller: 'AdminLoginEditController', controllerAs: 'lc' },
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
         for(var key in params) {
           var regexp = new RegExp(':' + key + '\\b');
           route = route.replace(regexp, params[key]);
         }
       }
       return route + '?ajax=true';
     };
  };

  var app = angular.module('moon');

  app.config(['$routeProvider', RouterBuilder]);
})(window._, window.angular);
