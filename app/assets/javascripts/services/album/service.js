(function(_, angular, undefined) {
  function AlbumsServiceFactory($http) {
    return new CommentsService($http);
  }

  function AlbumsService($http) {
    this.requester = $http;
  }

  var fn = AlbumsService.prototype,
      module = angular.module('album/service', []);

  fn.index = function(thread_id) {
    var url = '/album.json';

    return this.requester.get(url);
  };

  module.service('albumsService', ['$http', AlbumsService]);
})(window._, window.angular);
