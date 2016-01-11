(function(_, undefined) {
  var Account;

  function LinkFactory(accountModel) {
    Account = accountModel;
    return Link;
  }

  function Link(link) {
    _.extend(this, link);
    this.account = new Account(link.account);
  }

  var fn = Link.prototype,
      module = angular.module('gifts/link', ['bank/account']);

  module.factory('Link', ['Account', LinkFactory]);
})(_);
