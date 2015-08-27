(function(_) {
  function InviteController($routeParams, service, notifier) {
    this.service = service;
    this.selected = $routeParams;
    this.invite = {};

    _.bindAll(this, '_parseResponse', '_parseInvite', 'setInvite');
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
    var selected = this.selected;
    if (! (selected && (selected.id || selected.code))) {
      return;
    }

    if (selected.id) {
      this._fetchById(this.selected.id);
    } else {
      this._fetchByCode(this.selected.code);
    }
  };

  fn._fetchById = function(id) {
    this.service.get(id).success(this._parseInvite);
  };

  fn._fetchByCode = function(code) {
    this.service.getByCode(code).success(this._parseInvite);
  };

  fn._parseInvite = function(data) {
    var invite = data;

    this.invite = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  fn._parseResponse = function(data) {
    this._parseInvite(data.invite);
  };

  app.controller('InviteController', ['$routeParams', 'invitesService', 'notifier', InviteController]);
})(window._);
