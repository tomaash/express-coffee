"use strict"

angular.module "myApp.services", [], ($provide, Restangular) ->
  $provide.factory 'UsersResource', ->
    Restangular.all('users')

