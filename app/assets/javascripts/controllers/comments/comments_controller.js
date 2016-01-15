(function(_) {
  var Comment;

  function CommentsController(service, commentModel, notifier) {
    this.service = service;
    this.comments = [];
    Comment = commentModel;

    _.bindAll(this, 'loadComments', '_parseComments', '_addComment');

    notifier.register('open-comments', this.loadComments);
  }

  var fn = CommentsController.prototype;
      app = angular.module('comments/comment_controller', [
        'comments/service', 'comments/comment', 'notifier'
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
    this.comments = _.map(comments, function(comment) {
      return new Comment(comment);
    });

    this.loaded = true;
  };

  fn._addComment = function(comment) {
    this.comments.unshift(new Comment(comment));
  };

  fn.submit = function() {
    var promisse = this.service.create(this.thread_id, this.comment);
    promisse.success(this._addComment);
  };

  app.controller('CommentsController', [
    'commentsService', 'Comment', 'notifier', CommentsController
  ]);
})(window._);
