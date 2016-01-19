(function(_, angular, querystring, undefined) {
  function GiftsServiceFactory($http) {
    return new GiftsService($http);
  }

  function GiftsService($http) {
    this.requester = $http;
  }

  var fn = GiftsService.prototype,
      module = angular.module('gifts/service', []);

  fn.loadGifts = function(page, params) {
    page = page || 1;
    var path = '/presentes/pagina/' + page + '.json',
        url = path + '?' + querystring.encode(params);

    return this.requester.get(url);
  };

  fn.loadGiftLink = function(gift_id, link_id) {
    var url = '/presentes/' + gift_id + '/descricao/' + link_id + '.json';

    return this.requester.get(url);
  };

  fn.loadGift = function(gift_id) {
    var url = '/presentes/' + gift_id + '.json';

    return this.requester.get(url);
  };

  module.service('giftsService', ['$http', GiftsServiceFactory]);
})(window._, window.angular, window.querystring);
