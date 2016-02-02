(function(_, angular) {
  function AdminLoginEditController(service) {
    this.login = {};

    this.service = service;

    _.bindAll(this, '_markLogged', '_markLogged');

    this._load();
  }

  var fn = AdminLoginEditController.prototype,
      app = angular.module('admin/login/edit', ['admin/service']);

  fn._load = function() {
    var promisse = this.service.check();

    promisse.success(this._markLogged);
    promisse.error(this._markNotLogged);
  };

  fn.performLogin = function() {
    var promisse = this.service.login(this.login.password);

    promisse.success(this._markLogged);
    promisse.error(this._markNotLogged);
  };

  fn._markLogged = function() {
    this.logged = true;
  };

  fn._markNotLogged = function() {
    this.logged = false;
  };

  app.controller('AdminLoginEditController', [
    'adminService', AdminLoginEditController
  ]);
})(window._, window.angular);
