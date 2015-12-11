(function(_) {
  function GiftShowController($routeParams, giftsService) {
    this.service = giftsService;
    this.params = $routeParams;
  }

  var fn = GiftShowController.prototype;
      app = angular.module('gifts/show_controller', ['gifts/service']);

  app.controller('GiftShowController', [
    '$routeParams', 'giftsService', GiftShowController
  ]);
})(window._);
