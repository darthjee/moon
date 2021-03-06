(function(_, angular, undefined) {
  function GiftFactory() {
    return Gift;
  }

  function Gift(gift) {
    _.extend(this, gift);

    this.price_range = this.price_range || [];

    this.priceless = this.display_type === 'priceless' || this.price_range.length <= 0 || this.max_price == 0.0;
    this.given = this.status === 'given' || (this.bought === this.quantity && this.quantity > 0);
  }

  var fn = Gift.prototype,
      module = angular.module('gifts/gift', []);

  fn.is_priceless = function() {
    if (this.priceless === undefined) {
      this.priceless = this.price_range.length <= 0 || this.display_type === 'priceless';
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
})(window._, window.angular);
