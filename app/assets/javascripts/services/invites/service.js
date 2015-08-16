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
    return this.requester.get('/convidados/'+id+'.json');
  };

  fn.update = function(id, invite) {
    return this.requester.patch('/convites/'+id+'.json', {
      invite: invite
    });
  };

  module.service('invitesService', ['$http', InvitesServiceFactory]);
})(window._);
