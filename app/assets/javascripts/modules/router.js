(function(_) {
  function Router($routeProvider) {
    $routeProvider.when('/', {
      templateUrl: '/?ajax=true'
    }).when('/guests', {
      templateUrl: '/guests?ajax=true'
    });
  }

  var fn = Router.prototype;

  var app = angular.module('moon');

  app.config(['$routeProvider', Router]);
})(window._);
