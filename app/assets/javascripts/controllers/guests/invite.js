(function(_, angular) {
  function InviteController($routeParams, service, notifier) {
    this.service = service;
    this.selected = $routeParams;
    this.invite = {};
    this.removed = [];

    _.bindAll(this, '_parseResponse', 'setInvite', '_showErrors', '_updateSuccess');
    notifier.register('select-invite', this.setInvite);
    this._fetch();
  }

  var fn = InviteController.prototype,
      app = angular.module('guests/invite', ['notifier', 'invites/service']);

  fn.setInvite = function(selected) {
    this.selected = selected;
    this._clearMessages();

    this._fetch();
  };

  fn.add = function() {
    this.invite.guests.push(this.removed.pop() || {});
  };

  fn.pop = function() {
    var guest = this.invite.guests.pop();

    if (guest && (guest.id || guest.name || guest.presence)) {
      this.removed.push(guest);
    }
  };

  fn.update = function() {
    var id = this.invite.id,
        invite = this.invite,
        promisse;

    this._clearMessages();

    promisse = this.service.update(id, invite, this.removed);
    promisse.error(this._showErrors);
    promisse.success(this._updateSuccess);
  };

  fn._showErrors = function(data) {
    this.errors = data.errors;
  };

  fn._clearMessages = function() {
    this.errors = {};
    this.success = false;
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

  fn.updateGuest = function(index) {
    var guest = this.invite.guests[index],
        presence = guest.presence;

    if (guest.name !== '') {
      guest.presence = presence !== false;
    } else {
      guest.presence = (presence === undefined) && undefined;
    }
  };

  fn._updateSuccess = function (data) {
    this._parseResponse(data);
    this.success = true;
  };

  fn._parseResponse = function(data) {
    var invite = data;

    this.invite = invite;

    invite.guests = invite.guests.expandSize(invite.invites || 1);
  };

  app.controller('InviteController', ['$routeParams', 'invitesService', 'notifier', InviteController]);
})(window._, window.angular);
