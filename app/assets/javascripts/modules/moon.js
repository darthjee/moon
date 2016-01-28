(function(angular) {
  var module = angular.module('moon', [
    'guests', 'gifts', 'ui.select2', 'ngRoute', 'colorpicker.module', 'ext/ceil',
    'passwords', 'comments', 'pictures', 'admin'
  ]);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
        'Content-Type': 'application/json;charset=utf-8'
    };
  }]);
})(window.angular);
