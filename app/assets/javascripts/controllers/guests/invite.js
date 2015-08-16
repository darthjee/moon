(function(_) {
  function InviteController($routeParams, service, notifier) {
    this.service = service;
    this.selected = $routeParams;
    this.invite = {};

    _.bindAll(this, '_parseResponse', 'setInvite');
    notifier.register('select-invite', this.setInvite);
    this._fetch();
  }

  var fn = InviteController.prototype;
      app = angular.module('guests/invite', ['notifier', 'invites/service']);

  fn.setInvite = function(selected) {
    this.selected = selected;

    this._fetch();
  };

  fn.update = function() {
    var id = this.invite.id,
        guests = this.invite.guests;

    this.service.update(id, {
      guests: guests
    });
  };

  fn._fetch = function() {
    var selected = this.selected,
        id;
    if (! (selected && selected.id)) {
      return;
    }
    id = this.selected.id;

    this.service.get(id).success(this._parseResponse);
  };

  fn._parseResponse = function(data) {
    var invite = data.invite,
        guest = data.guest;

    this.invite = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  app.controller('InviteController', ['$routeParams', 'invitesService', 'notifier', InviteController]);
})(window._);
