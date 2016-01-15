(function(_, undefined) {
  function UserFactory() {
    return User;
  }

  function User(user) {
    _.extend(this, user);
  }

  var fn = User.prototype,
      module = angular.module('users/User', []);

  module.factory('User', [UserFactory]);
})(_);
