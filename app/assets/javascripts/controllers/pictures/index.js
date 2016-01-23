(function(_, angular) {
  function PicturesListController($routeParams) {
  }

  var fn = PicturesListController.prototype,
      app = angular.module('pictures/list_controller', []);

  app.controller('PicturesListController', [
    '$routeParams', PicturesListController
  ]);
})(window._, window.angular);
