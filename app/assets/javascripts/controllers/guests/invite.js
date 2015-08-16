(function(_) {
  function InviteController($http, notifier) {
    this.requester = $http;
    this.guest_info = {};
    this.selected = {};
    this.invite_info = {};

    _.bindAll(this, '_parseResponse', 'setInvite');
    notifier.register('select-invite', this.setInvite);
  }

  var fn = InviteController.prototype;
      app = angular.module('guests/invite', ['notifier']);

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
    console.info(guests);

    this.requester.patch('/convites/'+id+'.json', {
      invite: {
        guests: guests
      }
    });
  };

  fn._fetch = function() {
    var controller = this,
        id = this.selected.id;

    this.requester.get('/convidados/'+id+'.json').then(this._parseResponse);
  };

  fn._parseResponse = function(res) {
    var invite = res.data.invite,
        guest = res.data.guest;

    this.guest_info = guest;
    this.invite_info = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
  };

  app.controller('InviteController', ['$http', 'Notifier', InviteController]);
})(window._);
