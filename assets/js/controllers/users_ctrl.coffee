"use strict"

@UsersCtrl = ($scope, Restangular) ->
  usersResource = Restangular.all('users')

  clearCurrentUser = ->
    $scope.currentUser = {}
    $scope.editMode = false

  getUserList = () ->
    $scope.users = usersResource.getList()

  getUserList()
  clearCurrentUser()

  $scope.createUser = ->
    if $scope.currentUser.id
      promise = $scope.currentUser.put
    else
      promise = -> usersResource.post($scope.currentUser)
    promise().then ->
      getUserList()
      clearCurrentUser()

  $scope.editUser = (user) ->
    $scope.currentUser = Restangular.copy(user)
    $scope.editMode = true

  $scope.deleteUser = (user) ->
    user.remove().then ->
      getUserList()

UsersCtrl.$inject = ['$scope','Restangular']
