(function(_, undefined) {
  function AccountFactory() {
    return Account;
  }

  function Account(account) {
    _.extend(this, account);

    this.savings = this.account_type == 'savings';
    this.checkings = this.account_type == 'checkings';
  }

  var fn = Account.prototype,
      module = angular.module('bank/account', []);

  module.factory('Account', [AccountFactory]);
})(_);
