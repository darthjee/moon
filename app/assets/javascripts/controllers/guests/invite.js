(function(_) {
  function InviteController($http) {
    this.requester = $http;
    this.guest_info = {};
    this.selected = {};
    this.invite_info = {};

    _.bindAll(this, '_parseResponse');
  }

  var fn = InviteController.prototype;

  fn.guest = function() {
    if (this.selected.id === this.guest_info.id) {
      return this.guest_info;
    } else {
      this.guest_info = this.selected;
      this.fetch();
      return this.selected;
    }
  };

  fn.invite = function() {
    if (this.selected.id === this.guest_info.id) {
      return this.invite_info;
    } else {
      this.guest_info = this.selected;
      this.fetch();
      return this.invite_info;
    }
  };

  fn.fetch = function() {
    var controller = this,
        id = this.selected.id;

    this.requester.get('/guests/'+id+'.json').then(this._parseResponse);
  };

  fn._parseResponse = function(res) {
    var invite = res.data.invite,
        guest = res.data.guest;

    this.guest_info = guest;
    this.invite_info = invite;

    invite.guests = invite.guests.expandSize(invite.invites);
};

  var app = angular.module('guests/invite', []);

  app.controller('InviteController', ['$http', InviteController]);
})(window._);
