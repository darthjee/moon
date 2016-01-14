(function(_) {
  var Gift;

  function GiftShowController($routeParams, giftsService, notifier, giftModel, linkModel) {
    this.service = giftsService;
    this.params = $routeParams;
    this.notifier = notifier;

    Gift = giftModel;
    Link = linkModel;

    _.bindAll(this, '_parseGift');

    this.load();
  }

  var fn = GiftShowController.prototype;
      app = angular.module('gifts/show_controller', [
        'gifts/service', 'gifts/gift', 'gifts/link', 'notifier'
      ]);

  fn.load = function() {
    this.loadGift();
  };

  fn.loadGift = function() {
    this.gift_id = this.params.id;
    var promisse = this.service.loadGift(this.gift_id);
    promisse.success(this._parseGift);
  };

  fn._parseGift = function(data) {
    this.gift = new Gift(data);
    this.links = data.gift_links;
    if (this.links.length == 1) {
      this.link = this.links[0];
    }

    this.loaded = true;
  };

  app.controller('GiftShowController', [
    '$routeParams', 'giftsService', 'notifier','Gift', 'Link', GiftShowController
  ]);
})(window._);
