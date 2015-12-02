(function(_) {
  function GiftsListController(giftsService) {
    this.service = giftsService;

    _.bindAll(this, '_parseGifts');

    this.loadGifts();

  }

  var fn = GiftsListController.prototype;
      app = angular.module('gifts/list_controller', ['gifts/service']);

  fn.loadGifts = function() {
    this.service.loadGifts().success(this._parseGifts);
  };

  fn._parseGifts = function(data) {
    this.gifts = data;
    this.loaded = true;
  };

  app.controller('GiftsListController', ['giftsService', GiftsListController]);
})(window._);
