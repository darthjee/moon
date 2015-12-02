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

  fn.breakIntoRows = function(rowSize) {
    var row, rows = [];

    rowSize = rowSize || 1;
    for (i = 0; i < this.length; i++) {
      var index = i % rowSize,
          e = this[i];

      if (!index) {
        row = [];
        rows.push(row);
      }

      row.push(e);
    }

    return rows;
  };
})([].constructor.prototype);
