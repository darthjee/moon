(function(_, undefined) {
  function GiftsServiceFactory($http) {
    return new GiftsService($http);
  }

  function GiftsService($http) {
    this.requester = $http;
  }

  var fn = GiftsService.prototype,
      module = angular.module('gifts/service', []);

  module.service('giftsService', ['$http', GiftsServiceFactory]);
})(window._);
