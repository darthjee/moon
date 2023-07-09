(function(_, angular, undefined) {
  function AlbumFactory() {
    return Album;
  }

  function Album(album) {
    _.extend(this, album);
  }

  var module = angular.module('albums/album', []);

  module.factory('Album', [AlbumFactory]);
})(window._, window.angular);
