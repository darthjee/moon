(function(_) {
  function Router($routeProvider) {
  }

  var fn = Router.prototype;

  var app = angular.module('Router', ['ngRoute']);

  app.config(['$routeProvider', Router]);
})(_);
