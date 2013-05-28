#= require ../components/jquery/jquery
#= require ../components/angular/angular
#= require ../components/angular-resource/angular-resource
#= require ../components/angular-ui/build/angular-ui
#= require ../components/restangular/dist/restangular
#= require ../components/underscore/underscore

#= require_tree ./directives
#= require_tree ./services
#= require_tree ./controllers

'use strict'

# Declare app level module which depends on filters, and services

myApp = angular.module('myApp', [
    'myApp.filters'
    'myApp.services'
    'myApp.directives'
    'ui'
    'restangular'
  ])

myApp.config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider
  .when '/users',
    templateUrl: 'partials/users'
    controller: UsersCtrl

  .when '/posts',
    templateUrl: 'partials/posts'
    controller: PostsCtrl

#  .when '/view1',
#    templateUrl: 'partials/view1'
#    controller: MyCtrl1
#
#  .when '/view2',
#    templateUrl: 'partials/view2'
#    controller: MyCtrl2

  .otherwise redirectTo: '/users'

  $locationProvider.html5Mode true
])

myApp.config(['RestangularProvider', (RestangularProvider) ->
  RestangularProvider.setBaseUrl('/api')
])

