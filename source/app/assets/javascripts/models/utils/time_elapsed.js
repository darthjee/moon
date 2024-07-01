(function(_, angular, undefined) {
  function TimeElapsedFactory() {
    return TimeElapsed;
  }

  function TimeElapsed(time_elapsed) {
    _.extend(this, time_elapsed);
    this[this.unit] = true;
  }

  var module = angular.module('utils/time_elapsed', []);

  module.factory('TimeElapsed', [TimeElapsedFactory]);
})(window._, window.angular);
