(function(_, angular, undefined) {
  function PasswordsServiceFactory($http) {
    return new PasswordsService($http);
  }

  function PasswordsService($http) {
    this.requester = $http;
  }

  var fn = PasswordsService.prototype,
      module = angular.module('passwords/service', []);

  fn.sendEmail = function(email) {
    return this.requester.post('/senha', {
      email: email
    });
  };

  fn.update = function(password) {
    return this.requester.post('/senha/atualizar', {
      password: password
    });
  };

  module.service('PasswordsService', ['$http', PasswordsServiceFactory]);
})(window._, window.angular);
