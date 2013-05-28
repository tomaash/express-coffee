"use strict"

@PostsCtrl = ($scope, Restangular) ->
  postsResource = Restangular.all('posts')
  $scope.currentPost = {}

  getPostList = ->
    if $scope.searchQuery
      query =
        conditions: JSON.stringify
          title: $scope.searchQuery
    $scope.posts = postsResource.getList(query)

  getPostList()

  $scope.search = ->
    getPostList()

  $scope.reload = ->
    delete $scope.searchQuery
    getPostList()


  $scope.createPost = ->
    postsResource.post($scope.currentPost).then ->
      getPostList()

PostsCtrl.$inject = ['$scope','Restangular']
