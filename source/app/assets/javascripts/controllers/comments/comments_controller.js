(function(_, angular) {
  var Comment;

  function CommentsController(service, commentModel, notifier) {
    this.service = service;
    this.comments = [];
    Comment = commentModel;

    _.bindAll(this, 'loadComments', '_parseComments', '_addComment', '_parseError');

    notifier.register('open-comments', this.loadComments);
  }

  var fn = CommentsController.prototype,
      app = angular.module('comments/comment_controller', [
        'comments/service', 'comments/comment', 'global/notifier'
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
    this.comment = {};
  };

  fn.submit = function() {
    this.errors = {};

    var promisse = this.service.create(this.thread_id, this.comment);
    promisse.success(this._addComment);
    promisse.error(this._parseError);
  };

  fn._parseError = function(data) {
    this.errors = data.errors;
  };

  app.controller('CommentsController', [
    'commentsService', 'Comment', 'notifier', CommentsController
  ]);
})(window._, window.angular);
