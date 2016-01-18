(function(_) {
  function BestManController(
    $routeParams, $location, notifier, loginService, bestManService
  ) {
    this.selected = $routeParams;
    this.location = $location;
    this.loginService = loginService;
    this.service = bestManService;
    this.requireLogin();
    _.bindAll(this, '_parseInvite', '_parseAllFromRole', '_findPerson');
  }

  var fn = BestManController.prototype,
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

  fn.saveGuest = function(guest_id) {
    var guest = _.find(this.invite.guests, function(guest) {
      return guest.id === guest_id;
    });

    this.service.update(guest_id, guest);
  };

  fn.loadData = function() {
    this.service.getFromSession().success(this._parseInvite);
  };

  fn._parseInvite = function(data) {
    this.invite = data;
    this.motherData = this._buildRoleData('mother');
    this.maidData = this._buildRoleData('maid_honor');
    this.menData = this._buildRoleData('best_man');
    this.hasPeople = this._checkHasPeople();
  };

  fn._checkHasPeople = function() {
    list = [ this.maidData.hasPeople, this.menData.hasPeople ];
    return _.any(list, function(i) {
      return i;
    });
  };

  fn._buildRoleData = function(role) {
    people = this._filterGuests(role);
    roleData = {
      people: people,
      hasPeople: !people.empty()
    };
    this.service.listFromRole(role).success(this._parseAllFromRole(roleData));
    return roleData;
  };

  fn._filterGuests = function(role) {
    return _.select(this.invite.guests, function(guest) {
      return guest.role === role;
    });
  };

  fn._parseAllFromRole = function(roleData) {
    var that = this;
    return function(data) {
      roleData.all = _.map(data, function(current) {
        return that._findPerson(roleData, current);
      });
    };
  };

  fn._findPerson = function(roleData, target) {
    return _.find(roleData.people, function(person) {
      return target.id === person.id;
    }) || target;
  };

  app.controller('BestManController', [
    '$routeParams', '$location', 'notifier', 'loginService', 'bestManService',
    BestManController
  ]);
})(window._);
