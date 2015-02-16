# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app')
 
app.controller('ShareHoldersCtrl', ['$scope', '$http', '$window', 'uiGridConstants', ($scope, $http, $window, uiGridConstants) ->
  $scope.loading = false
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'name', displayName: "Nombre", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'equity', displayName: "Capital Invertido", cellFilter: 'number', enableFiltering: false },
      { field: 'earnings', displayName: "Utilidad", cellFilter: 'number', enableFiltering: false },
      { field: 'stock_prepaid', displayName: "Adelanto", cellFilter: 'number', enableFiltering: false }
    ]
  }
  
  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi
    gridApi.selection.on.rowSelectionChanged($scope, (row) ->
      $window.location.href="share_holders/" + row.entity.id
    )

  $scope.doQuery = ->
    $scope.loading = true
    $http.post('/share_holders/search.json', $scope.query)
      .success (data) ->
        $scope.loading = false
        $scope.gridOptions.data = data
      .error (data) ->
        $scope.loading = false

])
