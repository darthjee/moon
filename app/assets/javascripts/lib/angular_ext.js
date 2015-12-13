(function() {
  var app = angular.module('ext/ceil', []);

  app.filter('ceil', function() {
    return function(n) {
      return Math.ceil(parseFloat(n));
    };
  });
})();
