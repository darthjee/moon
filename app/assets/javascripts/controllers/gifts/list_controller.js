(function(_) {
  function GiftsListController(giftsService) {
    this.service = giftsService;

    this.loaded = true;
  }

  var fn = GiftsListController.prototype;
      app = angular.module('gifts/list_controller', ['gifts/service']);

  app.controller('GiftsListController', ['giftsService', GiftsListController]);
})(window._);
