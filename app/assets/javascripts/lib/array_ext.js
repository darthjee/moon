(function(fn, undefined) {
  fn.expandSize = function(size, constructor) {
    constructor = (constructor == undefined) ? ({}).constructor : constructor;

    while (size > this.length) {
      this.push(new constructor);
    }

    return this;
  };
})([].constructor.prototype);
