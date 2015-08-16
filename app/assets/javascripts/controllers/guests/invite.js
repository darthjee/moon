(function(_) {
  function InviteController(service, notifier) {
    this.service = service;
    this.selected = {};
    this.invite = {};

    _.bindAll(this, '_parseResponse', 'setInvite');
    notifier.register('select-invite', this.setInvite);
  }

  var fn = InviteController.prototype;
      app = angular.module('guests/invite', ['notifier', 'invites/service']);

  fn.setInvite = function(selected) {
    this.selected = selected;

    if (selected && selected.id) {
      this._fetch();
    }
  };

  fn.update = function() {
    var id = this.invite.id,
        guests = this.invite.guests;

    this.service.update(id, {
      guests: guests
    });
  };

  fn._fetch = function() {
    var id = this.selected.id;

    this.service.get(id, this._parseResponse);
  };

  fn._parseResponse = function(data) {
    var invite = data.invite,
        guest = data.guest;

    this.invite = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  app.controller('InviteController', ['invitesService', 'notifier', InviteController]);
})(window._);
