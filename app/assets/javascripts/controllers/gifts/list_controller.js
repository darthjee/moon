(function(_, angular, querystring) {
  var Gift, Paginator;

  function GiftsListController($routeParams, giftsService, giftModel, paginator) {
    this.service = giftsService;
    this.page = $routeParams.page || 1;
    this.params = $routeParams;

    Gift = giftModel;
    Paginator = paginator;

    _.bindAll(this, '_parseGifts');

    this.loadGifts();
  }

  var fn = GiftsListController.prototype,
      app = angular.module('gifts/list_controller', [
        'gifts/service', 'gifts/gift', 'utils/paginator'
      ]);

  fn.loadGifts = function() {
    this.service.loadGifts(this.page, this.params).then(this._parseGifts);
  };

  fn.orderBy = function(param) {
    if (this.params.sort_by === param) {
      if (this.params.sort_direction === 'desc') {
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
    return this.params.sort_by === param && this.params.sort_direction === type;
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
      return new Gift(gift);
    });
  };

  fn.markGiven = function(id) {
    this.service.update(id, { given: true } );
  };

  fn.buildPagination = function(data) {
    return Paginator.from_data(3, data).build();
  };

  app.controller('GiftsListController', [
    '$routeParams', 'giftsService', 'Gift', 'paginator', GiftsListController
  ]);
})(window._, window.angular, window.querystring);
