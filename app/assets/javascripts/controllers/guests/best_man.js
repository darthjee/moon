(function(_) {
  function BestManController(
    $routeParams, $location, notifier, loginService, bestManService
  ) {
    this.selected = $routeParams;
    this.location = $location;
    this.loginService = loginService;
    this.service = bestManService;
    this.requireLogin();
    _.bindAll(this, '_parseInvite', '_parseMaids', '_matchMaid');
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

  fn.saveMaid = function(index) {
    var maid = this.maids[index];

    this.service.update(maid.id, maid);
  };

  fn.loadData = function() {
    this.service.getFromSession().success(this._parseInvite);
    this.service.getMaids().success(this._parseMaids);
  };

  fn._parseInvite = function(data) {
    this.invite = data;
    this.maids = _.select(data.guests, function(guest) {
      return guest.role == 'maid_honor';
    });
    this.men = _.select(data.guests, function(guest) {
      return guest.role = 'best_man';
    });
    this.hasPeople = [].concat(this.men, this.maids).length > 0;
    this._matchMaids();
  };

  fn._parseMaids = function(data) {
    this.allMaids = data;
    this._matchMaids();
  };

  fn._matchMaids = function() {
    _.each(this.maids, this._matchMaid);
  };

  fn._matchMaid = function(maid) {
    this.allMaids = _.map(this.allMaids, function(current) {
      return (current.id == maid.id) ? maid : current;
    });
  };

  app.controller('BestManController', [
    '$routeParams', '$location', 'notifier', 'loginService', 'bestManService',
    BestManController
  ]);
})(window._);
