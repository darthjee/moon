(function(_, angular, undefined) {
  function GuestsServiceFactory($http) {
    return new GuestsService($http);
  }

  function GuestsService($http) {
    this.requester = $http;
  }

  var fn = GuestsService.prototype,
      module = angular.module('guests/service', []);

  fn.search = function(term, callback) {
    return this.requester.get('/convidados/search.json', {
      params: { name: term }
    });
  };

  module.service('guestsService', ['$http', GuestsServiceFactory]);
})(window._, window.angular);
