(function(_, undefined) {
  function InvitesServiceFactory($http) {
    return new InvitesService($http);
  }

  function InvitesService($http) {
    this.requester = $http;
  }

  var fn = InvitesService.prototype,
      module = angular.module('invites/service', []);

  fn.get = function(id, callback) {
    this.requester.get('/convidados/'+id+'.json').then(function(res) {
      callback(res.data);
    });
  };

  fn.update = function(id, invite) {
    this.requester.patch('/convites/'+id+'.json', {
      invite: invite
    });
  };

  module.service('invitesService', ['$http', InvitesServiceFactory]);
})(window._);
