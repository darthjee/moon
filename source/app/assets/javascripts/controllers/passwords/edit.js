(function(_, angular) {
  function PasswordEditController(service, loginService) {
    this.service = service;
    this.loginService = loginService;

    _.bindAll(this, '_parseUser', '_success', '_fail');
    this.load();
  }

  var fn = PasswordEditController.prototype,
      app = angular.module('passwords/edit', [
        'passwords/service',
        'guests/login_service'
      ]);

  fn.load = function() {
    this.loginService.getUser().success(this._parseUser);
  };

  fn.update = function() {
    this.success = false;

    if (!this._equalPassword()) {
      this.error = 'Digite a mesma senha em ambos os campos';
    } else if (!this._filledPassword()){
      this.error = 'Digite uma senha para atualizar';
    } else {
      this._sendUpdate();
    }
  };

  fn._sendUpdate = function() {
    var promisse;
    this.error = null;
    promisse = this.service.update(this.user.password);

    promisse.success(this._success);
    promisse.error(this._fail);
  };

  fn._validPassword = function() {
    return this._equalPassword() && this._filledPassword();
  };

  fn._equalPassword = function() {
    return this.user.password === this.user.password_confirmation;
  };

  fn._filledPassword = function() {
    var password = this.user.password;
    return password !== null && password !== '';
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
})(window._, window.angular);
