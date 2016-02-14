(function(_, angular) {
  var Picture;

  function PicturesListController($routeParams, picturesService, albumsService, pictureModel) {
    Picture = pictureModel;

    this.service = picturesService;
    this.albumsService = albumsService;
    this.page = $routeParams.page || 1;
    this.album_id = $routeParams.album_id;
    this.params = $routeParams;

    _.bindAll(this, '_loadPictures', '_parsePictures', '_parseAlbums');

    this._loadAlbums();
    this._loadPictures();
  }

  var fn = PicturesListController.prototype,
      app = angular.module('pictures/list_controller', [
        'pictures/service', 'album/service', 'pictures/picture'
      ]);

  fn._loadPictures = function() {
    this.service.index(this.page, this.album_id, this.params).success(this._parsePictures);
  };

  fn._loadAlbums = function() {
    this.albumsService.index().success(this._parseAlbums);
  };

  fn._parseAlbums = function(data) {
    this.albums = data;
  };

  fn.update = function(picture) {
    var id = picture.id,
        promisse = this.service.update(this.album_id, id, picture);

    promisse.success(this._loadPictures);
  };

  fn._parsePictures = function(data) {
    this.pictures = _.map(data.pictures, function(pic) {
      return new Picture(pic);
    });
    this.pages = data.pages;
    this.pagination = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
  };

  fn.buildPagination = function(data) {
    return Paginator.from_data(3, data).build();
  };

  app.controller('PicturesListController', [
    '$routeParams', 'picturesService', 'albumsService', 'Picture',
    PicturesListController
  ]);
})(window._, window.angular);
