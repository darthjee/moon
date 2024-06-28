(function(angular) {
  var module = angular.module("moon");

  module.config(["johtoProvider", function(provider) {
    provider.defaultConfig = {
      controller: "Cyberhawk.Controller",
      controllerAs: "gnc",
      templateBuilder: function(route, params) {
        return route + "?ajax=true";
      }
    }

    provider.configs = [{
      routes: ["/"],
      config: {
        controller: "Home.Controller",
        controllerAs: "hc"
      }
    }];
    provider.$get().bindRoutes();
  }]);
}(window.angular));

