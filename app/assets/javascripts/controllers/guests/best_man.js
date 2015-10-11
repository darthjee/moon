(function(_) {
  function BestManController($routeParams, $location, notifier, loginService) {
    this.selected = $routeParams;
    this.location = $location;
    this.loginService = loginService;
    this.requireLogin();
  }

  var fn = BestManController.prototype;
      app = angular.module('guests/best_man', []);

  fn.requireLogin = function() {
    var that = this;

    that.loginService.isLogged().error(function () {
      that.location.url('/login?redirect_to=/padrinhos');
    });
  };

  app.controller('BestManController', ['$routeParams', '$location', 'notifier', 'loginService', BestManController]);
})(window._);
