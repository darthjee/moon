(function(_) {
  function BestManController($routeParams, $location, notifier) {
    this.selected = $routeParams;
    this.location = $location;
    this.requireLogin();
  }

  var fn = BestManController.prototype;
      app = angular.module('guests/best_man', []);

  fn.requireLogin = function() {
    this.location.path('/login');
  };

  app.controller('BestManController', ['$routeParams', '$location', 'notifier', BestManController]);
})(window._);
