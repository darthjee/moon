(function(_, angular) {
  function PasswordRecoveryController(service) {
    this.service = service;
    this.success = false;

    _.bindAll(this, '_emailSent', '_emailNotSent');
  }

  var fn = PasswordRecoveryController.prototype,
      app = angular.module('passwords/recovery', [
        'passwords/service'
      ]);

  fn.sendEmail = function() {
    var promisse = this.service.sendEmail(this.email);

    this.error = null;
    this.success = false;

    promisse.success(this._emailSent);
    promisse.error(this._emailNotSent);
  };

  fn._emailSent = function() {
    this.success = true;
  };

  fn._emailNotSent = function(data, status) {
    switch(status){
      case 404:
        this.error = 'E-mail não encontrado, verifique se foi cadastrado um e-mail na confirmação de presença';
        break;
      default:
        this.error = 'Ocorreu um erro no envio do e-mail';
    }


  };

  app.controller('PasswordRecoveryController', [
    'PasswordsService', PasswordRecoveryController
  ]);
})(window._, window.angular);
