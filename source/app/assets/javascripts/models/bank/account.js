(function(_, angular, undefined) {
  function AccountFactory() {
    return Account;
  }

  function Account(account) {
    _.extend(this, account);

    this.savings = this.account_type === 'savings';
    this.checkings = this.account_type === 'checkings';
  }

  var module = angular.module('bank/account', []);

  module.factory('Account', [AccountFactory]);
})(window._, window.angular);
