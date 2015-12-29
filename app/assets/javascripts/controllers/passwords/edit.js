(function(_) {
  function PasswordEditController(service) {
    this.service = service;
  }

  var fn = PasswordEditController.prototype;
      app = angular.module('passwords/edit', [
        'passwords/service'
      ]);

  app.controller('PasswordEditController', [
    'PasswordsService', PasswordEditController
  ]);
})(window._);
