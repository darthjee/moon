(function(_) {
  function CommentsController(service, notifier) {
    this.service = service;

    _.bindAll(this, 'loadComments', '_parseComments');

    notifier.register('open-comments', this.loadComments);
  }

  var fn = CommentsController.prototype;
      app = angular.module('comments/comment_controller', [
        'comments/service', 'notifier'
      ]);

  fn.loadComments = function(thread_id) {
    this.loaded = false;
    this.thread_id = thread_id;

    this.loadThisComments();
  };

  fn.loadThisComments = function() {
    var promisse = this.service.loadComments(this.thread_id);
    promisse.success(this._parseComments);
  };

  fn._parseComments = function(comments) {
    this.comments = comments;

    this.loaded = true;
  };

  fn.submit = function() {
    var promisse = this.service.create(this.thread_id, this.comment);
    promisse.success(this._parseComments);
  };

  app.controller('CommentsController', [
    'commentsService', 'notifier', CommentsController
  ]);
})(window._);
