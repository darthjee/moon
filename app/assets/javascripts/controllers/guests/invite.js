(function(_) {
  function InviteController($http) {
    this.requester = $http;
    this.guest_info = {};
    this.selected = {};
    this.invite_info = {};
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

    this.requester.get('/guests/'+id+'.json').then(function(res) {
      var invite = res.data.invite,
          guest = res.data.guest;

      controller.guest_info = guest;
      controller.invite_info = invite;

      if (invite.guests.length < invite.invites) {
        invite.guests = invite.guests.concat(new Array(invite.invites - invite.guests.length));
      }
    });
  };

  var app = angular.module('guests/invite', []);

  app.controller('InviteController', ['$http', InviteController]);
})(window._);
