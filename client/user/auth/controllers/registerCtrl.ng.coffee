angular.module('food-collective').controller 'RegisterCtrl', ($meteor, $state) ->
  vm = this
  vm.credentials =
    email: ''
    password: ''
    profile:
      name: ""
      address: ""
      phone: ""

  vm.error = ''

  vm.hubs = $meteor.collection Hubs
  .subscribe 'hubs'

  vm.register = ->
    $meteor.createUser(vm.credentials).then (->
      $state.go 'store'
      return
    ), (err) ->
      vm.error = 'Registration error - ' + err
      return
    return

  vm.facebookLogin = ->
    $meteor.loginWithFacebook
      requestPermissions: ['email']
    .then (result) ->
      console.log(result)
    , (err) ->
      vm.error = "Login Error: #{err}"

  return

# ---
# generated by js2coffee 2.1.0
