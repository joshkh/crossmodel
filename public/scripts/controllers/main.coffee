'use strict'

###*
 # @ngdoc function
 # @name crossmodelApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the crossmodelApp
###
angular.module 'crossmodelApp'
  .controller 'MainCtrl', ($scope, $http, $q, DTOptionsBuilder, DTColumnBuilder) ->

    $scope.exists = (name, arr) -> if name in arr then return name else null

    mines = $http.get '/mines'
    models = $http.get '/modelsarr'

    $scope.dtOptions = DTOptionsBuilder.fromSource('modelsarr').withOption('paging', false)

    debugger
    # .withPaginationType('full_numbers');

    $scope.dtColumns = [
      DTColumnBuilder.newColumn('key').withTitle('KEY')
    ]


    $q.all([mines, models]).then (res, err) ->

      $scope.mines = res[0].data
      $scope.classes = res[1].data


    return
