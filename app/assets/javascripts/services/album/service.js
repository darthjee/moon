(function(_, angular, undefined) {
  function AlbumsServiceFactory($http) {
    return new AlbumsService($http);
  }

  function AlbumsService($http) {
    this.requester = $http;
  }

  var fn = AlbumsService.prototype,
      module = angular.module('album/service', []);

  fn.index = function() {
    var url = '/album.json';

    return this.requester.get(url);
  };

  module.service('albumsService', ['$http', AlbumsServiceFactory]);
})(window._, window.angular);
