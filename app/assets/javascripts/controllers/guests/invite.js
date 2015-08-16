(function(_) {
  function InviteController(service, notifier) {
    this.service = service;
    this.guest_info = {};
    this.selected = {};
    this.invite_info = {};

    _.bindAll(this, '_parseResponse', 'setInvite');
    notifier.register('select-invite', this.setInvite);
  }

  var fn = InviteController.prototype;
      app = angular.module('guests/invite', ['notifier', 'invites/service']);

  fn.setInvite = function(id) {
    this.selected = id;
  };

  fn.guest = function() {
    if (this.selected.id === this.guest_info.id) {
      return this.guest_info;
    } else {
      this.guest_info = this.selected;
      this._fetch();
      return this.selected;
    }
  };

  fn.invite = function() {
    if (this.selected.id === this.guest_info.id) {
      return this.invite_info;
    } else {
      this.guest_info = this.selected;
      this._fetch();
      return this.invite_info;
    }
  };

  fn.update = function() {
    var id = this.invite_info.id,
        guests = this.invite_info.guests;

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

    this.guest_info = guest;
    this.invite_info = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  app.controller('InviteController', ['invitesService', 'notifier', InviteController]);
})(window._);
