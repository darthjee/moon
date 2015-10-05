(function(_) {
  function LoginController(service) {
    this.service = service;
  }

  var fn = LoginController.prototype;
      app = angular.module('guests/login', ['guests/login_service']);

  fn.performLogin = function() {
    console.info(this.login);
    var promisse = this.service.login(this.login);

    promisse.success(function(){
      console.info(arguments);
    });
  };

  app.controller('LoginController', ['loginService', LoginController]);
})(window._);
