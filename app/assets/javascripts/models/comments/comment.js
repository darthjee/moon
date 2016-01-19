(function(_, angular, undefined) {
  var User, TimeElapsed;


  function CommentFactory(userModel, timeElapsedModel) {
    User = userModel;
    TimeElapsed = timeElapsedModel;

    return Comment;
  }

  function Comment(comment) {
    _.extend(this, comment);

    this.user = new User(this.user);
    this.time_elapsed = new TimeElapsed(this.time_elapsed);
  }

  var module = angular.module('comments/comment', ['users/user', 'utils/time_elapsed']);

  module.factory('Comment', ['User', 'TimeElapsed', CommentFactory]);
})(_);
