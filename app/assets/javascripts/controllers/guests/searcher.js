(function(_) {
  function GuestsSearcherController($http) {
    this.requester = $http;
    this.options = [{ name: 'name1', id: 1 },{ name: 'name2', id: 2 }];
  }

  var fn = GuestsSearcherController.prototype;

  var app = angular.module('guests/searcher', []);

  app.controller('GuestsSearcherController', ['$http', GuestsSearcherController]);
})(_);
