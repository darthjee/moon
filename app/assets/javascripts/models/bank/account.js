(function(_, undefined) {
  function AccountFactory() {
    return Account;
  }

  function Account(account) {
    _.extend(this, account);
  }

  var fn = Account.prototype,
      module = angular.module('bank/account', []);

  module.factory('Account', [AccountFactory]);
})(_);
