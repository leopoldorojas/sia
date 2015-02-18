# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app')
 
app.controller('SharesCtrl', ['$scope', '$http', 'uiGridConstants', '$window', ($scope, $http, uiGridConstants, $window) ->
  $scope.loading = false
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'identifier', displayName: "Número" },
      { field: 'share_type_identifier', displayName: "Tipo", enableFiltering: false },
      { field: 'share_value', displayName: "Valor", cellFilter: 'number', enableFiltering: false },
      { field: 'share_holder_name', displayName: "Socio", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'share_operation_id', displayName: "Identificador de Operación" }
      { field: 'share_operation_date', displayName: "Fecha de Operación" }
    ]
  }

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi

  $scope.doQuery = ->
    $scope.loading = true
    $http.post('/shares/search.json', $scope.query)
      .success (data) ->
        $scope.loading = false
        $scope.gridOptions.data = data
      .error (data) ->
        $scope.loading = false

])