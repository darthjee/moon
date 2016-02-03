(function(_, angular) {
  function PicturesListController($routeParams, picturesService, albumsService) {
    this.service = picturesService;
    this.albumsService = albumsService;
    this.page = $routeParams.page || 1;
    this.album_id = $routeParams.album_id;
    this.params = $routeParams;

    _.bindAll(this, '_parsePictures', '_parseAlbums');

    this._loadAlbums();
    this._loadPictures();
  }

  var fn = PicturesListController.prototype,
      app = angular.module('pictures/list_controller', [
        'pictures/service', 'album/service'
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
    console.info(picture);
  };

  fn._parsePictures = function(data) {
    this.pictures = data.pictures;
    this.pages = data.pages;
    this.pagination = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
  };

  fn.buildPagination = function(data) {
    var current = data.page,
        that = this, list;

    list = _.map(new Array(data.pages), function(_, index) {
      var page =  index + 1;
      if (that.isPageListable(page, data.pages, current, 3)) {
        return page;
      }
      return null;
    });

    return _.squeeze(list);
  };

  fn.isPageListable = function(page, total, current, blockSize) {
    return page <= blockSize ||
           page > total - blockSize ||
           Math.abs(page - current) < blockSize ||
           (Math.abs(page - current) <= blockSize && page <= (blockSize+1)) ||
           (Math.abs(page - current) <= blockSize && page >= total - blockSize);
  };

  app.controller('PicturesListController', [
    '$routeParams', 'picturesService', 'albumsService', PicturesListController
  ]);
})(window._, window.angular);
