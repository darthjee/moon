(function(_) {
  function Router($routeProvider) {
    $routeProvider.when('/', {
      templateUrl: '/?ajax=true'
    }).when('/convidados', {
      templateUrl: '/convidados?ajax=true'
    });
  }

  var fn = Router.prototype;

  var app = angular.module('moon');

  app.config(['$routeProvider', Router]);
})(window._);
