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
    this.pages = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
  };

  fn.buildPagination = function(data) {
    var current = data.page;

    list = _.map(new Array(data.pages), function(_, index) {
      var page =  index + 1;
      if (page <= 3 || page >= data.pages - 3 || Math.abs(page - current) <= 2) {
        return page;
      }
      return null;
    });

    return list;
  };

  app.controller('GiftsListController', [
    '$routeParams', 'giftsService', GiftsListController
  ]);
})(window._);
