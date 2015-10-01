(function(_) {
  function InviteController($routeParams, service, notifier) {
    this.service = service;
    this.selected = $routeParams;
    this.invite = {};

    _.bindAll(this, '_parseResponse', 'setInvite', '_showErrors');
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
        invite = this.invite,
        promisse;

    this._clearErrors();

    promisse = this.service.update(id, invite);
    promisse.error(this._showErrors);
  };

  fn._showErrors = function(data) {
    this.errors = data.errors;
  };

  fn._clearErrors = function() {
    this.errors = {};
  };

  fn._fetch = function() {
    var selected = this.selected;
    if (! (selected && (selected.id || selected.code))) {
      return;
    }

    if (selected.code) {
      this._fetchByCode(this.selected.code);
    } else {
      this._fetchById(this.selected.id);
    }
  };

  fn._fetchById = function(id) {
    this.service.getByGuestId(id).success(this._parseResponse);
  };

  fn._fetchByCode = function(code) {
    this.service.getByCode(code).success(this._parseResponse);
  };

  fn.update_guest = function(index) {
    var guest = this.invite.guests[index],
        presence = guest.presence;

    if (guest.name != '') {
      guest.presence = presence !== false;
    } else {
      guest.presence = (presence == undefined) && undefined;
    }
  };

  fn._parseResponse = function(data) {
    var invite = data;

    this.invite = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  app.controller('InviteController', ['$routeParams', 'invitesService', 'notifier', InviteController]);
})(window._);
