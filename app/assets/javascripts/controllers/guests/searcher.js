(function(_) {
  function GuestsSearcherController() {
  }

  var fn = GuestsSearcherController.prototype;

  var app = angular.module('guests/searcher', []);

  app.controller('GuestsSearcherController', [GuestsSearcherController]);
})(_);