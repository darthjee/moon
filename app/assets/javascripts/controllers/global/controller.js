(function(_, angular) {
  function GlobalController(adminService, notifier) {
    this.adminService = adminService;
    this.notifier = notifier;

    _.bindAll(this, 'loginAdmin');

    this.start();
  }

  var fn = GlobalController.prototype,
      app = angular.module('global/controller', [
        'admin/service', 'global/notifier'
      ]);

  fn.start = function() {
    this.notifier.register('login-admin', this.loginAdmin);

    this._checkAdmin();
  };

  fn._checkAdmin = function() {
    var promisse = this.adminService.check();

    promisse.then(this.loginAdmin);
  };

  fn.loginAdmin = function() {
    this.admin = {
      name: 'Admin'
    };
  };

  app.controller('GlobalController', [
    'adminService', 'notifier', GlobalController
  ]);
})(window._, window.angular);
