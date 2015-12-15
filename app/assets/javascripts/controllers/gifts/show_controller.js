(function(_) {
  function GiftShowController($routeParams, giftsService) {
    this.service = giftsService;
    this.params = $routeParams;

    _.bindAll(this, '_parseGiftLink', '_parseGift');

    this.load();
  }

  var fn = GiftShowController.prototype;
      app = angular.module('gifts/show_controller', ['gifts/service']);

  fn.load = function() {
    if (this.params.gift_id) {
      this.loadGiftLink();
    } else {
      this.loadGift();
    }
  };

  fn.loadGiftLink = function() {
    this.gift_id = this.params.gift_id;
    this.link_id = this.params.id;
    var promisse = this.service.loadGiftLink(this.gift_id, this.link_id);
    promisse.success(this._parseGiftLink);
  };

  fn._parseGiftLink = function(data) {
    this.link = data;
    this.gift = data.gift;
    this.loaded = true;
  };

  fn.loadGift = function() {
    this.gift_id = this.params.id;
    var promisse = this.service.loadGift(this.gift_id);
    promisse.success(this._parseGift);
  };

  fn._parseGift = function(data) {
    this.gift = data;
    this.links = data.gift_links;
    if (this.links.length == 1) {
      this.link = this.links[0];
    }

    this.loaded = true;
  };

  app.controller('GiftShowController', [
    '$routeParams', 'giftsService', GiftShowController
  ]);
})(window._);
