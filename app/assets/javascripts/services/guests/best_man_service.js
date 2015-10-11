(function(_, undefined) {
  function LoginServiceFactory($http) {
    return new LoginService($http);
  }

  function LoginService($http) {
    this.requester = $http;
  }

  var fn = LoginService.prototype,
      module = angular.module('guests/login_service', []);

  fn.login = function(login) {
    return this.requester.post('/login', login);
  };

  fn.isLogged = function() {
    return this.requester.get('/login/check');
  };

  module.service('loginService', ['$http', LoginServiceFactory]);
})(window._);
