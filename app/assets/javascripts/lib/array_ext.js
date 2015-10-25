(function(fn, undefined) {
  fn.expandSize = function(size, builder) {
    if (builder == undefined) {
      builder = function() { return {}; };
    }

    while (size > this.length) {
      this.push(builder(this.length));
    }

    return this;
  };

  fn.empty = function() {
    return this.length == 0;
  };
})([].constructor.prototype);
