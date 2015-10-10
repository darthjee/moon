(function(_) {
  function LoginController($routeParams, $location, service) {
    this.redirect_to = $routeParams.redirect_to || '/';
    this.service = service;
    this.location = $location;

    _.bindAll(this, 'redirect');
  }

  var fn = LoginController.prototype;
      app = angular.module('guests/login', ['guests/login_service']);

  fn.redirect = function() {
    this.location.url(this.redirect_to);
  };

  fn.performLogin = function() {
    console.info(this.login);
    var promisse = this.service.login(this.login);

    promisse.success(this.redirect);
  };

  app.controller('LoginController', ['$routeParams', '$location', 'loginService', LoginController]);
})(window._);
