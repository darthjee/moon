(function(_, undefined) {
  var User;

  function CommentFactory(userModel) {
    User = userModel;

    return Comment;
  }

  function Comment(comment) {
    _.extend(this, comment);

    this.user = new User(this.user);
  }

  var fn = Comment.prototype,
      module = angular.module('comments/comment', ['users/User']);

  module.factory('Comment', ['User', CommentFactory]);
})(_);
