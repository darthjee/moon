(function(_, angular) {
  var Gift;

  function GiftShowController($routeParams, giftsService, notifier, giftModel) {
    this.service = giftsService;
    this.params = $routeParams;
    this.notifier = notifier;

    Gift = giftModel;

    _.bindAll(this, '_parseGift');

    this.load();
  }

  var fn = GiftShowController.prototype,
      app = angular.module('gifts/show_controller', [
        'gifts/service', 'gifts/gift', 'notifier'
      ]);

  fn.load = function() {
    this.gift_id = this.params.id;
    var promisse = this.service.loadGift(this.gift_id);
    promisse.success(this._parseGift);
  };

  fn._parseGift = function(data) {
    this.gift = new Gift(data);
    this.links = data.gift_links;

    this.notifier.notify('open-comments', this.gift.thread_id);

    this.loaded = true;
  };

  app.controller('GiftShowController', [
    '$routeParams', 'giftsService', 'notifier','Gift', GiftShowController
  ]);
})(window._, window.angular);
