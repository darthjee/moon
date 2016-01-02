(function(_) {
  function PasswordEditController(service, loginService) {
    this.service = service;
    this.loginService = loginService;

    _.bindAll(this, '_parseUser', '_success', '_fail');
    this.load();
  }

  var fn = PasswordEditController.prototype;
      app = angular.module('passwords/edit', [
        'passwords/service',
        'guests/login_service'
      ]);

  fn.load = function() {
    this.loginService.getUser().success(this._parseUser);
  };

  fn.update = function() {
    this.error = null;
    this.success = false;

    var promisse = this.service.update(this.user.password);
    promisse.success(this._success);
    promisse.error(this._fail);
  };

  fn._parseUser = function(data) {
    this.user = data;
  };

  fn._success = function() {
    this.success = true;
  };

  fn._fail = function() {
    this.error = 'Houve uma falha na atualização da senha';
  };

  app.controller('PasswordEditController', [
    'PasswordsService', 'loginService', PasswordEditController
  ]);
})(window._);
