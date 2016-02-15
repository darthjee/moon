(function(_, angular, querystring, undefined) {
  function AlbumsServiceFactory($http) {
    return new AlbumsService($http);
  }

  function AlbumsService($http) {
    this.requester = $http;
  }

  var fn = AlbumsService.prototype,
      module = angular.module('album/service', []);

  fn.index = function(page, params) {
    page = page || 1;
    params = params || {};

    var path = '/album/pagina/' + page + '.json',
        url = path + '?' + querystring.encode(params);

    return this.requester.get(url);
  };

  module.service('albumsService', ['$http', AlbumsServiceFactory]);
})(window._, window.angular, window.querystring);
