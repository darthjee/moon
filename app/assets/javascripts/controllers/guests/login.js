(function(_, angular) {
  function LoginController($routeParams, $location, service) {
    this.redirect_to = $routeParams.redirect_to || '/';
    this.service = service;
    this.location = $location;

    _.bindAll(this, '_redirect', '_fail');
  }

  var fn = LoginController.prototype,
      app = angular.module('guests/login', ['guests/login_service']);

  fn._redirect = function() {
    this.location.url(this.redirect_to);
  };

  fn.performLogin = function() {
    this.error = null;
    var promisse = this.service.login(this.login);

    promisse.then(this._redirect);
    promisse.error(this._fail);
  };

  fn._fail = function(data, status) {
    switch(status) {
      case(404):
        this.error = 'E-mail ou senha incorreto';
        break;
      default:
        this.error = 'Ocorreu uma falha no login';
    }
  };

  app.controller('LoginController', ['$routeParams', '$location', 'loginService', LoginController]);
})(window._, window.angular);
