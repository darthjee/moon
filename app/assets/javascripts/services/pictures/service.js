(function(_, angular, undefined) {
  function PicturesServiceFactory($http) {
    return new PicturesService($http);
  }

  function PicturesService($http) {
    this.requester = $http;
  }

  var fn = PicturesService.prototype,
      module = angular.module('pictures/service', []);

  fn.index = function(page, album_id, params) {
    page = page || 1;
    var path = '/album/' + album_id + '/fotos/pagina/' + page + '.json',
        url = path + '?' + querystring.encode(params);

    return this.requester.get(url);
  };

  module.service('picturesService', ['$http', PicturesServiceFactory]);
})(window._, window.angular);
