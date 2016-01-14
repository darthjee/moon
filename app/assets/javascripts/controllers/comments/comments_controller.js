(function(_) {
  function CommentsController(notifier) {
    notifier.register('open-comments', this.loadComments);
  }

  var fn = CommentsController.prototype;
      app = angular.module('comments/comment_controller', ['notifier']);

  fn.loadComments = function() {
    console.info(arguments);
  };

  app.controller('CommentsController', [
    'notifier', CommentsController
  ]);
})(window._);
