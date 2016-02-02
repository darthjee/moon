(function(_, angular, undefined) {
  function NotifierServiceFactory() {
    return new NotifierService();
  }

  function NotifierService() {
    this.watchs = {};
  }

  var fn = NotifierService.prototype,
      module = angular.module('global/notifier', []);

  fn.notify = function(key, value) {
    _.each(this.listeners(key), function(callback) {
      callback(value);
    });
  };

  fn.register = function(key, callback) {
    this.listeners(key).push(callback);
  };

  fn.listeners = function(key) {
    if (this.watchs[key] === undefined) {
      this.watchs[key] = [];
    }
    return this.watchs[key];
  };

  module.service('notifier', [NotifierServiceFactory]);
})(window._, window.angular);
