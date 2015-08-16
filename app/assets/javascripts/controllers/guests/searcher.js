(function(_) {
  function GuestsSearcherController(service, notifier) {
    this.service = service;
    this.notifier = notifier;

    this.options = [{ name: 'name1', id: 1 },{ name: 'name2', id: 2 }];
    _.bindAll(this, 'search');
  }

  var fn = GuestsSearcherController.prototype;
      app = angular.module('guests/searcher', ['notifier', 'guests/service']);

  fn.search = function(query) {
    var controller = this;

    this.service.search(query.term, function(data) {
      var results = controller._parseGuests(data);
      query.callback({ results: results });
    });
  };

  fn._parseGuests = function(data) {
    return _.map(data, function(object) {
      return {
        text: object.name,
        id: object.id
      };
    });
  };

  fn.change = function() {
    this.notifier.notify('select-invite', this.selected);
  };

  app.controller('GuestsSearcherController', ['guestsService', 'notifier', GuestsSearcherController]);
})(window._);
