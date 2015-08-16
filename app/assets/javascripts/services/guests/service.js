(function(_, undefined) {
  function GuestsServiceFactory($http) {
    return new GuestsService($http);
  }

  function GuestsService($http) {
    this.requester = $http;
  }

  var fn = GuestsService.prototype,
      module = angular.module('guests/service', []);

  fn.search = function(term, callback) {
    this.requester.get('/convidados/search.json', {
      params: { name: term }
    }).then(function(res) {
      callback(res.data);
    });
  };

  module.service('guestsService', ['$http', GuestsServiceFactory]);
})(window._);
