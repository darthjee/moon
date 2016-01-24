(function(_, angular) {
  function PicturesListController($routeParams, picturesService) {
    this.service = picturesService;
    this.page = $routeParams.page || 1;
    this.album_id = $routeParams.album_id;
    this.params = $routeParams;

    this.loadPictures();
  }

  var fn = PicturesListController.prototype,
      app = angular.module('pictures/list_controller', ['pictures/service']);

  fn.loadPictures = function() {
    this.service.index(this.page, this.album_id, this.params).success(this._parsePictures);
  };

  fn._parsePictures = function(data) {
    console.info(data);
  };

  app.controller('PicturesListController', [
    '$routeParams', 'picturesService', PicturesListController
  ]);
})(window._, window.angular);
