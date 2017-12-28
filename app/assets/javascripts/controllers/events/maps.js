(function(_, angular) {
  function MapsController($routeParams, service) {
    this.params = $routeParams;
    this.service = service;

    _.bindAll(this, '_parseEvents');

    this._loadEvents();
  }

  var fn = MapsController.prototype,
      app = angular.module('events/maps_controller', ['events/service']);

  fn._loadEvents = function() {
    this.service.index().success(this._parseEvents);
  };

  fn._parseEvents = function(data) {
    this.events = data;
  };

  app.controller('MapsController', [
    '$routeParams', 'eventsService',
    MapsController
  ]);
})(window._, window.angular);
