(function(_, angular) {
  function GlobalController() {
  }

  var fn = GlobalController.prototype,
      app = angular.module('global/controller', []);

  app.controller('GlobalController', [
    GlobalController
  ]);
})(window._, window.angular);
