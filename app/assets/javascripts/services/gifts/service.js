(function(_, undefined) {
  function GiftsServiceFactory($http) {
    return new GiftsService($http);
  }

  function GiftsService($http) {
    this.requester = $http;
  }

  var fn = GiftsService.prototype,
      module = angular.module('gifts/service', []);

  fn.loadGifts = function() {
    return this.requester.get('/presentes.json');
  };

  module.service('giftsService', ['$http', GiftsServiceFactory]);
})(window._);
