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

  fn.create = function(thread_id, comment) {
    var url = '/threads/' + thread_id + '/comments';

    return this.requester.post(url, comment);
  };

  module.service('commentsService', ['$http', CommentsServiceFactory]);
})(window._);
