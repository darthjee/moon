(function(_, undefined) {
  function LinkFactory() {
    return Link;
  }

  function Link(link) {
    _.extend(this, link);
  }

  var fn = Link.prototype,
      module = angular.module('gifts/link', []);

  module.factory('Link', [LinkFactory]);
})(_);
