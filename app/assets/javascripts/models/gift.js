(function(_, undefined) {
  function Gift(gift) {
    _.extend(this, gift);

    this.priceless = this.price_range.length <= 0 || this.display_type == 'priceless';
  }

  function GiftFactory(gift) {
    return Gift;
  }

  var module = angular.module('gifts/gift', []);

  module.factory('Gift', [GiftFactory]);
})(_);