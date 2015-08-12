(function() {
  var module = angular.module('moon', ['guests','ui.select2', 'ngRoute']);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
        'Content-Type': 'application/json;charset=utf-8'
    };
  }]);
})();
