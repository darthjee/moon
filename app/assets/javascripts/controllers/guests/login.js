(function(_) {
  function LoginController($location, service) {
    this.redirect_to = $location.$$path;
    this.service = service;
    this.location = $location;

    _.bindAll(this, 'redirect');
  }

  var fn = LoginController.prototype;
      app = angular.module('guests/login', ['guests/login_service']);

  fn.redirect = function() {
    console.info('redirect', this.redirect_to);
  };

  fn.performLogin = function() {
    console.info(this.login);
    var promisse = this.service.login(this.login);

    promisse.success(this.redirect);
  };

  app.controller('LoginController', ['$location', 'loginService', LoginController]);
})(window._);
