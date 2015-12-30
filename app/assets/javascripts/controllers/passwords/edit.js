(function(_) {
  function PasswordEditController(service) {
    this.service = service;

    _.bindAll(this, '_parseUser');
    this.load();
  }

  var fn = PasswordEditController.prototype;
      app = angular.module('passwords/edit', [
        'guests/login_service'
      ]);

  fn.load = function() {
    this.service.getUser().success(this._parseUser);
  };

  fn._parseUser = function(data) {
    this.user = data;
  };

  app.controller('PasswordEditController', [
    'loginService', PasswordEditController
  ]);
})(window._);
