(function(_, angular) {
  var Album, Paginator;

  function AlbumsListController($routeParams, albumsService, albumModel, paginator) {
    Album = albumModel;

    this.service = albumsService;
    this.page = $routeParams.page || 1;
    this.params = $routeParams;

    Paginator = paginator;

    _.bindAll(this, '_loadAlbums', '_parseAlbums');

    this._loadAlbums();
  }

  var fn = AlbumsListController.prototype,
      app = angular.module('albums/list_controller', [
        'album/service', 'albums/album', 'utils/paginator'
      ]);

  fn._loadAlbums = function() {
    this.service.index(this.page, this.album_id, this.params).success(this._parseAlbums);
  };

  fn._parseAlbums = function(data) {
    this.albums = _.map(data.albums, function(album) {
      return new Album(album);
    });
    this.pages = data.pages;
    this.pagination = this.buildPagination(data);
    this.page = data.page;
    this.loaded = true;
  };

  fn.buildPagination = function(data) {
    return Paginator.from_data(3, data).build();
  };

  app.controller('AlbumsListController', [
    '$routeParams', 'albumsService', 'Album', 'paginator',
    AlbumsListController
  ]);
})(window._, window.angular);
