isAdmin = (user) ->
  Roles.userIsInRole user, 'admin'

angular.module('food-coop').config ($stateProvider) ->
  $stateProvider.state 'page',
    url: '/directory/:producerId'
    templateUrl: 'client/directory/views/page.ng.html'
    controllerAs: 'ctrl'
    controller: 'pageCtrl'
    resolve:
      producer: ($meteor, $stateParams) ->
        return $meteor.subscribe 'producer', $stateParams.producerId
  .state 'directory',
    url: '/directory'
    templateUrl: 'client/directory/views/directory.ng.html'
    controllerAs: 'dir'
    controller: 'directoryCtrl'
  return

# ---
# generated by js2coffee 2.1.0