(function(fn) {
  fn.expandSize = function(size) {
    if (size > this.length) {
      return this.concat(new Array(size - this.length));
    } else {
      return this;
    }
  };
})([].constructor.prototype);
