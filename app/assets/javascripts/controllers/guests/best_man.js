(function(_) {
  function BestManController(
    $routeParams, $location, notifier, loginService, bestManService
  ) {
    this.selected = $routeParams;
    this.location = $location;
    this.loginService = loginService;
    this.service = bestManService;
    this.requireLogin();
    _.bindAll(this, '_parseData');
  }

  var fn = BestManController.prototype;
      app = angular.module('guests/best_man', ['guests/best_man_service']);

  fn.requireLogin = function() {
    var that = this,
        promisse = that.loginService.isLogged();

    promisse.error(function () {
      that.location.url('/login?redirect_to=/padrinhos');
    });
    promisse.success(function() {
      that.loadData();
    });
  };

  fn.loadData = function() {
    this.service.getFromSession().success(this._parseData);
  };

  fn._parseData = function(data) {
    this.invite = data;
    this.maids = _.select(data.guests, function(guest) {
      return guest.maid_honor;
    });
    this.men = _.select(data.guests, function(guest) {
      return guest.best_man;
    });
    this.hasPeople = [].concat(this.men, this.maids).length > 0;
  };

  app.controller('BestManController', [
    '$routeParams', '$location', 'notifier', 'loginService', 'bestManService',
    BestManController
  ]);
})(window._);
