(function(_, angular) {
  var Gift, Link;

  function GiftLinkShowController($routeParams, giftsService, notifier, giftModel, linkModel) {
    this.service = giftsService;
    this.params = $routeParams;
    this.notifier = notifier;

    Gift = giftModel;
    Link = linkModel;

    _.bindAll(this, '_parseGiftLink');

    this.load();
  }

  var fn = GiftLinkShowController.prototype,
      app = angular.module('gifts/link_controller', [
        'gifts/service', 'gifts/gift', 'gifts/link', 'global/notifier'
      ]);

  fn.load = function() {
    this.gift_id = this.params.gift_id;
    this.link_id = this.params.id;
    var promisse = this.service.loadGiftLink(this.gift_id, this.link_id);
    promisse.success(this._parseGiftLink);
  };

  fn._parseGiftLink = function(data) {
    this.link = new Link(data);
    this.gift = new Gift(data.gift);

    this.notifier.notify('open-comments', this.gift.thread_id);

    this.loaded = true;
  };

  app.controller('GiftLinkShowController', [
    '$routeParams', 'giftsService', 'notifier','Gift', 'Link', GiftLinkShowController
  ]);
})(window._, window.angular);
