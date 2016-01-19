(function(_, angular, md5, undefined) {
  function UserFactory() {
    return User;
  }

  function User(user) {
    _.extend(this, user);
  }

  var fn = User.prototype,
      module = angular.module('users/user', []);

  fn.gravatarUrl = function() {
    var hash = md5(this.email);
    return 'http://www.gravatar.com/avatar/' + hash + '.jpg';
  };

  module.factory('User', [UserFactory]);
})(_, md5);
