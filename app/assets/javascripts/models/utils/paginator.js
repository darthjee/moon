(function(_, angular, undefined) {
  function PaginatorFactory() {
    return Paginator;
  }

  function Paginator(blockSize, pages, current) {
    this.blockSize = blockSize;
    this.pages = pages;
    this.current = current;
  }

  var module = angular.module('utils/paginator', []),
      fn = Paginator.prototype;

  Paginator.from_data = function(block_size, data) {
    return new Paginator(block_size, data.pages, data.page);
  };

  fn.build = function() {
    var list = that = this;

    list = _.map(new Array(that.pages), function(_, index) {
      var page =  index + 1;
      if (that.isPageListable(page)) {
        return page;
      }
      return null;
    });

    return _.squeeze(list);
  };

  fn.isPageListable = function(page) {
    var total = this.pages,
        current = this.current;
        blockSize = this.blockSize;

    return page <= blockSize ||
           page > total - blockSize ||
           Math.abs(page - current) < blockSize ||
           (Math.abs(page - current) <= blockSize && page <= (blockSize+1)) ||
           (Math.abs(page - current) <= blockSize && page >= total - blockSize);
  };


  module.factory('paginator', [PaginatorFactory]);
})(window._, window.angular);

