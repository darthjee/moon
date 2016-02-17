(function(_, angular) {
  function MapsController($routeParams) {
    this.params = $routeParams;
  }

  var fn = MapsController.prototype,
      app = angular.module('events/maps_controller', []);

  app.controller('MapsController', [
    '$routeParams',
    MapsController
  ]);
})(window._, window.angular);
