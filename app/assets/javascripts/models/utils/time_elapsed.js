(function(_, undefined) {
  function TimeElapsedFactory() {
    return TimeElapsed;
  }

  function TimeElapsed(time_elapsed) {
    _.extend(this, time_elapsed);
  }

  var fn = TimeElapsed.prototype,
      module = angular.module('utils/time_elapsed', []);

  module.factory('TimeElapsed', [TimeElapsedFactory]);
})(_);
