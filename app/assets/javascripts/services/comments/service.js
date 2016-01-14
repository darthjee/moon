(function(_, undefined) {
  function CommentsServiceFactory($http) {
    return new CommentsService($http);
  }

  function CommentsService($http) {
    this.requester = $http;
  }

  var fn = CommentsService.prototype,
      module = angular.module('comments/service', []);

  fn.loadComments = function(thread_id) {
    var url = '/threads/' + thread_id + '/comments';

    return this.requester.get(url);
  };

  module.service('commentsService', ['$http', CommentsServiceFactory]);
})(window._);
