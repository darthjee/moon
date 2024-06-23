(function(_, angular, undefined) {
  function EventsServiceFactory($http) {
    return new EventsService($http);
  }

  function EventsService($http) {
    this.requester = $http;
  }

  var fn = EventsService.prototype,
      module = angular.module('events/service', []);

  fn.all = function() {
    return this.index(1, { per_page: 0 });
  };

  fn.index = function() {
    var path = '/eventos.json';

    return this.requester.get(path);
  };

  module.service('eventsService', ['$http', EventsServiceFactory]);
})(window._, window.angular);
