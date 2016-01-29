(function(_, angular) {
  function AdminLoginEditController(service) {
    this.login = {};

    this.service = service;

    _.bindAll(this, '_logiSuccess', '_logiSuccess');
  }

  var fn = AdminLoginEditController.prototype,
      app = angular.module('admin/login/edit', ['admin/service']);

  fn.performLogin = function() {
    var promisse = this.service.login(this.login.password);

    promisse.success(this._logiSuccess);
    promisse.error(this._logiFailure);
  };

  fn._logiSuccess = function() {
    this.logged = true;
  };

  fn._logiFailure = function() {
    this.logged = false;
  };

  app.controller('AdminLoginEditController', [
    'adminService', AdminLoginEditController
  ]);
})(window._, window.angular);
