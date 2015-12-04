(function(_, undefined) {
  function GiftsServiceFactory($http) {
    return new GiftsService($http);
  }

  function GiftsService($http) {
    this.requester = $http;
  }

  var fn = GiftsService.prototype,
      module = angular.module('gifts/service', []);

  fn.loadGifts = function(page) {
    page = page || 1;
    return this.requester.get('/presentes/page/' + page + '.json');
  };

  module.service('giftsService', ['$http', GiftsServiceFactory]);
})(window._);
