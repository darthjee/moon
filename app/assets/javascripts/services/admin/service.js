(function(_, angular, undefined) {
  function AdminServiceFactory($http) {
    return new AdminService($http);
  }

  function AdminService($http) {
    this.requester = $http;
  }

  var fn = AdminService.prototype,
      module = angular.module('admin/service', []);

  fn.login = function(code) {
    return this.requester.get('/admin.json?admin_key=' + code);
  };

  module.service('adminService', ['$http', AdminServiceFactory]);
})(window._, window.angular);
