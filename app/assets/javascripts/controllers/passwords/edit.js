(function(_) {
  function PasswordEditController(service, loginService) {
    this.service = service;
    this.loginService = loginService;

    _.bindAll(this, '_parseUser', '_success');
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
    this.service.update(this.password).success(this._success);
  };

  fn._parseUser = function(data) {
    this.user = data;
  };

  fn._success = function() {
  };

  app.controller('PasswordEditController', [
    'PasswordsService', 'loginService', PasswordEditController
  ]);
})(window._);
