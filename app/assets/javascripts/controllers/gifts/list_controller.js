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
      if (this.params.desc) {
        delete(this.params.desc);
        this.params.asc = true;
      } else {
        delete(this.params.asc);
        this.params.desc = true;
      }
    }
    this.params.sort_by = param;
    window.location.href = this.pageUrl(1);
  };

  fn.pageUrl = function(page) {
    return '/#/presentes/pagina/' + page + '?' + this.sortParams();
  };

  fn.sortParams = function() {
    var params = { sort_by: this.params.sort_by };

    if (this.params.desc) {
      params.desc = true;
    } else {
      params.asc = true;
    }
    return querystring.encode(params);
  };

  fn._parseGifts = function(data) {
    this.gifts = data.gifts;
    this.pages = data.pages;
    this.pagination = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
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
