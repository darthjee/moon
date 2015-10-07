(function(_) {
  function BestManController($routeParams, notifier) {
    this.selected = $routeParams;
  }

  var fn = BestManController.prototype;
      app = angular.module('guests/best_man', []);

  app.controller('BestManController', ['$routeParams', 'notifier', BestManController]);
})(window._);
