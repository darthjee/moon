(function(_, angular) {
  function GuestsSearcherController(service, notifier) {
    this.service = service;
    this.notifier = notifier;

    this.options = [];
    _.bindAll(this, 'search', '_parseGuest');
  }

  var fn = GuestsSearcherController.prototype,
      app = angular.module('guests/searcher', ['global/notifier', 'guests/service']);

  fn.search = function(query) {
    var controller = this;

    this.service.search(query.term).success(function(data) {
      var results = controller._parseGuests(data);
      query.callback({ results: results });
    });
  };

  fn._parseGuests = function(data) {
    return _.map(data, this._parseGuest);
  };

  fn._parseGuest = function(data) {
    if (data.code) {
      return {
        text: data.label,
        id: data.code,
        code: data.code
      };
    } else {
      return {
        text: data.name,
        id: data.id
      };
    }
  };

  fn.change = function() {
    this.notifier.notify('select-invite', this.selected);
  };

  app.controller('GuestsSearcherController', ['guestsService', 'notifier', GuestsSearcherController]);
})(window._, window.angular);
