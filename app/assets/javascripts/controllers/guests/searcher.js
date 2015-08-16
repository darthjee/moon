(function(_) {
  function GuestsSearcherController($http, notifier) {
    this.requester = $http;
    this.notifier = notifier;

    this.options = [{ name: 'name1', id: 1 },{ name: 'name2', id: 2 }];
    _.bindAll(this, 'search');
  }

  var fn = GuestsSearcherController.prototype;
      app = angular.module('guests/searcher', ['notifier']);

  fn.search = function(query) {
    this.requester.get('/convidados/search.json', {
      params: { name: query.term }
    }).then(function(res) {
      var results = _.map(res.data, function(object) {
        return {
          text: object.name,
          id: object.id
        };
      });
      query.callback({ results: results });
    });
  };

  fn.change = function() {
    this.notifier.notify('select-invite', this.selected);
  };

  app.controller('GuestsSearcherController', ['$http', 'notifier', GuestsSearcherController]);
})(window._);
