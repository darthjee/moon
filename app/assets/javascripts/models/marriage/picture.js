(function(_, angular, undefined) {
  function PictureFactory() {
    return Picture;
  }

  function Picture(picture) {
    _.extend(this, picture);
    this.album_id = picture.album_id.toString();
  }

  var fn = Picture.prototype,
      module = angular.module('pictures/picture', []);

  module.factory('Picture', [PictureFactory]);
})(window._, window.angular);
