(function(_, angular, undefined) {
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

  fn.getUser = function() {
    return this.requester.get('/login/usuario');
  };

  module.service('loginService', ['$http', LoginServiceFactory]);
})(window._, window.angular);
