(function(_, angular) {
  function GlobalController(notifier) {
    this.notifier = notifier;

    _.bindAll(this, 'loginAdmin');

    this.bind();
  }

  var fn = GlobalController.prototype,
      app = angular.module('global/controller', ['global/notifier']);

  fn.bind = function() {
    this.notifier.register('login-admin', this.loginAdmin);
  };

  fn.loginAdmin = function() {
    this.admin = {
      name: 'Admin'
    };
  };

  app.controller('GlobalController', [
    'notifier', GlobalController
  ]);
})(window._, window.angular);
