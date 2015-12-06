(function(_) {
  function GiftsListController($routeParams, giftsService) {
    this.service = giftsService;
    this.page = $routeParams.page || 1;

    _.bindAll(this, '_parseGifts');

    this.loadGifts();
  }

  var fn = GiftsListController.prototype;
      app = angular.module('gifts/list_controller', ['gifts/service']);

  fn.loadGifts = function() {
    this.service.loadGifts(this.page).success(this._parseGifts);
  };

  fn._parseGifts = function(data) {
    this.gifts = data.gifts;
    this.pages = this.buildPagination(data.pages);
    this.page = data.page;
    this.loaded = true;
  };

  fn.buildPagination = function(pages) {
    return _.map(new Array(pages), function(_, index) { return index + 1; });
  };

  app.controller('GiftsListController', [
    '$routeParams', 'giftsService', GiftsListController
  ]);
})(window._);
