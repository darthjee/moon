(function(_, undefined) {
  function GiftFactory(gift) {
    return Gift;
  }

  function Gift(gift) {
    _.extend(this, gift);

    this.priceless = this.price_range.length <= 0 || this.display_type == 'priceless';
  }

  var fn = Gift.prototype,
      module = angular.module('gifts/gift', []);

  fn.is_priceless = function() {
    if (this.priceless == undefined) {
      this.priceless = his.price_range.length <= 0 || this.display_type == 'priceless';
    }
    return this.priceless;
  };

  module.factory('Gift', [GiftFactory]);
})(_);