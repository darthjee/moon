(function(_, undefined) {
  function BestManServiceFactory($http) {
    return new BestManService($http);
  }

  function BestManService($http) {
    this.requester = $http;
  }

  var fn = BestManService.prototype,
      module = angular.module('guests/best_man_service', []);

  fn.getFromSession = function() {
    return this.requester.get('/padrinho.json');
  };

  fn.getMaids = function() {
    return this.requester.get('/madrinhas.json');
  };

  fn.update = function(id, guest) {
    return this.requester.patch('/padrinho/' + id + '.json', {
      guest: guest
    });
  };

  module.service('bestManService', ['$http', BestManServiceFactory]);
})(window._);
