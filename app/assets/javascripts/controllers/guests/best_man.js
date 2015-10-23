(function(_) {
  function BestManController(
    $routeParams, $location, notifier, loginService, bestManService
  ) {
    this.selected = $routeParams;
    this.location = $location;
    this.loginService = loginService;
    this.service = bestManService;
    this.requireLogin();
    _.bindAll(this, '_parseInvite');
  }

  var fn = BestManController.prototype;
      app = angular.module('guests/best_man', ['guests/best_man_service']);

  fn.requireLogin = function() {
    var that = this,
        promisse = that.loginService.isLogged();

    promisse.error(function () {
      that.location.url('/login?redirect_to=/padrinhos/informativo');
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
  };

  fn._parseInvite = function(data) {
    this.invite = data;
    this.maidData = this._buildRoleData('maid_honor');
    //this.menData = this._buildRoleData('best_man');
    //this.hasPeople = [].concat(this.men, this.maids).length > 0;
    this.hasPeople = true;
  };

  fn._buildRoleData = function(role) {
    roleData = {
      people: _.select(this.invite.guests, function(guest) {
        return guest.role == role;
      })
    };
    this.service.listFromRole(role).success(function(data) {
      roleData.all = _.map(data, function(current) {
        return _.find(roleData.people, function(maid) {
          return current.id == maid.id;
        }) || current;
      });
    });
    return roleData;
  };

  app.controller('BestManController', [
    '$routeParams', '$location', 'notifier', 'loginService', 'bestManService',
    BestManController
  ]);
})(window._);
