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
    return this.requester.get('/padrinhos/informativo.json');
  };

  fn.listFromRole = function(role) {
    var urls = {
     'maid_honor': '/madrinhas.json',
     'best_man': '/padrinhos.json',
     'mother': '/maes.json'
    };

    return this.requester.get(urls[role]);
  };

  fn.update = function(id, guest) {
    return this.requester.patch('/padrinhos/' + id + '.json', {
      guest: guest
    });
  };

  module.service('bestManService', ['$http', BestManServiceFactory]);
})(window._);
