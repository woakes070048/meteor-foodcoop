angular.module('food-coop').config ($stateProvider) ->
  $stateProvider.state 'directory',
    url: '/directory'
    templateUrl: 'client/directory/views/directory.ng.html'
    controllerAs: 'dir'
    controller: 'directoryCtrl'
  return

# ---
# generated by js2coffee 2.1.0
