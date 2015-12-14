(function(_) {
  function GiftShowController($routeParams, giftsService) {
    this.service = giftsService;
    this.gift_id = $routeParams.gift_id;
    this.link_id = $routeParams.id;

    _.bindAll(this, '_parseGift');

    this.loadGiftLink();
  }

  var fn = GiftShowController.prototype;
      app = angular.module('gifts/show_controller', ['gifts/service']);

  fn.loadGiftLink = function() {
    var promisse = this.service.loadGiftLink(this.gift_id, this.id);
    promisse.success(this._parseGift);
  };

  fn._parseGift = function(data) {
    this.link = data;
    this.gift = data.gift;
    this.loaded = true;
  };

  app.controller('GiftShowController', [
    '$routeParams', 'giftsService', GiftShowController
  ]);
})(window._);
