(function(_, undefined) {
  function GiftsServiceFactory($http) {
    return new GiftsService($http);
  }

  function GiftsService($http) {
    this.requester = $http;
  }

  var fn = GiftsService.prototype,
      module = angular.module('gifts/service', []);

  fn.loadGifts = function(page, params) {
    page = page || 1;
    return this.requester.get('/presentes/pagina/' + page + '.json', params);
  };

  module.service('giftsService', ['$http', GiftsServiceFactory]);
})(window._);
