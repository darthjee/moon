(function(_) {
  function PasswordRecoveryController(service) {
    this.service = service;

    _.bindAll(this, '_emailSent', '_emailNotSent');
  }

  var fn = PasswordRecoveryController.prototype;
      app = angular.module('passwords/recovery', [
        'passwords/service'
      ]);

  fn.sendEmail = function() {
    var promisse = this.service.sendEmail(this.email);

    promisse.success(this._emailSent);
    promisse.error(this._emailNotSent);
  };

  fn._emailSent = function() {
    console.info('email sent');
  };

  fn._emailNotSent = function() {
    console.info('email not sent');
  };

  app.controller('PasswordRecoveryController', [
    'PasswordsService', PasswordRecoveryController
  ]);
})(window._);
