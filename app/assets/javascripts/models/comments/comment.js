(function(_, undefined) {
  var User, TimeElapsed;


  function CommentFactory(userModel, timeElapsedModel) {
    User = userModel;
    TimeElapsed = TimeElapsed;

    return Comment;
  }

  function Comment(comment) {
    _.extend(this, comment);

    this.user = new User(this.user);
    this.time_elapsed = new TimeElapsed(this.time_elapsed);
  }

  var fn = Comment.prototype,
      module = angular.module('comments/comment', ['users/user', 'utils/time_elapsed']);

  module.factory('Comment', ['User', CommentFactory, TimeElapsed]);
})(_);
