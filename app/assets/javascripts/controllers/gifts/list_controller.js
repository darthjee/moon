(function(_) {
  function GiftsListController($routeParams, giftsService) {
    this.service = giftsService;
    this.page = $routeParams.page || 1;
    this.params = $routeParams;

    _.bindAll(this, '_parseGifts');

    this.loadGifts();
  }

  var fn = GiftsListController.prototype;
      app = angular.module('gifts/list_controller', ['gifts/service']);

  fn.loadGifts = function() {
    this.service.loadGifts(this.page, this.params).success(this._parseGifts);
  };

  fn.orderBy = function(param) {
    if (this.params.sort_by == param) {
      if (this.params.sort_direction == 'desc') {
        this.params.sort_direction = 'asc';
      } else {
        this.params.sort_direction = 'desc';
      }
    } else {
      this.params.sort_by = param;
      this.params.sort_direction = 'asc';
    }
    window.location.href = this.pageUrl(1);
  };

  fn.orderedBy = function(param, type) {
    return this.params.sort_by == param && this.params.sort_direction == type;
  };

  fn.pageUrl = function(page) {
    return '/#/presentes/pagina/' + page + '?' + this.sortParams();
  };

  fn.sortParams = function() {
    var params = {
      sort_by: this.params.sort_by,
      sort_direction: this.params.sort_direction
    };

    return querystring.encode(params);
  };

  fn._parseGifts = function(data) {
    this.gifts = this.completeGifts(data.gifts);
    this.pages = data.pages;
    this.pagination = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
  };

  fn.completeGifts = function(gifts) {
    return _.map(gifts, function(gift) {
      gift.priceless = gift.price_range.length <= 0 || gift.display_type == 'priceless';
      return gift;
    });
  };

  fn.buildPagination = function(data) {
    var current = data.page,
        that = this;

    list = _.map(new Array(data.pages), function(_, index) {
      var page =  index + 1;
      if (that.isPageListable(page, data.pages, current, 3)) {
        return page;
      }
      return null;
    });

    return _.squeeze(list);
  };

  fn.isPageListable = function(page, total, current, blockSize) {
    return page <= blockSize ||
           page > total - blockSize ||
           Math.abs(page - current) < blockSize ||
           (Math.abs(page - current) <= blockSize && page <= (blockSize+1)) ||
           (Math.abs(page - current) <= blockSize && page >= total - blockSize);
  };

  app.controller('GiftsListController', [
    '$routeParams', 'giftsService', GiftsListController
  ]);
})(window._);
