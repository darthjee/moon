(function(_) {
  function GuestsSearcherController($http) {
    this.requester = $http;
    this.options = [{ name: 'name1', id: 1 },{ name: 'name2', id: 2 }];
    _.bindAll(this, 'search');
  }

  var fn = GuestsSearcherController.prototype;

  fn.search = function(query) {
    this.requester.get('/guests/search.json', {
      params: { name: query.term }
    }).then(function(res){
      var results = _.map(res.data, function(object) {
        return {
          text: object.name,
          id: object.id
        };
      });
      query.callback({ results: results });
    });
  };

  var app = angular.module('guests/searcher', []);

  app.controller('GuestsSearcherController', ['$http', GuestsSearcherController]);
})(_);
