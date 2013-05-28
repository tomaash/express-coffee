"use strict"

@PostsCtrl = ($scope, Restangular) ->
  postsResource = Restangular.all('posts')
  $scope.currentPost = {}

  getPostList = ->
    $scope.posts = postsResource.getList()

  getPostList()

  $scope.createPost = ->
    postsResource.post($scope.currentPost).then ->
      getPostList()

PostsCtrl.$inject = ['$scope','Restangular']
