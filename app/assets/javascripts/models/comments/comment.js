(function(_, undefined) {
  function CommentFactory() {
    return Comment;
  }

  function Comment(comment) {
    _.extend(this, comment);
  }

  var fn = Comment.prototype,
      module = angular.module('comments/comment', []);

  module.factory('Comment', [CommentFactory]);
})(_);
