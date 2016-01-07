(function(_, undefined) {
  function GiftFactory(gift) {
    return Gift;
  }

  function Gift(gift) {
    _.extend(this, gift);

    this.price_range = this.price_range || [];

    this.priceless = this.display_type == 'priceless' || this.price_range.length <= 0;
    this.given = this.status == 'given';
  }

  var fn = Gift.prototype,
      module = angular.module('gifts/gift', []);

  fn.is_priceless = function() {
    if (this.priceless == undefined) {
      this.priceless = his.price_range.length <= 0 || this.display_type == 'priceless';
    }
    return this.priceless;
  };

  fn.has_many_packages = function() {
    return this.packages_quantity > 1;
  };

  fn.has_many = function() {
    return this.quantity > 1;
  };

  module.factory('Gift', [GiftFactory]);
})(_);
