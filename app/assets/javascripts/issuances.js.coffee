# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid', 'ui.grid.selection'])
 
app.controller('IssuancesCtrl', ['$scope', '$http', 'uiGridConstants', 'dateFilter', '$window', ($scope, $http, uiGridConstants, dateFilter, $window) ->
  termValue = dateFilter(new Date(), 'yyyy-MM')
  $scope.loading = false
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'issue_date', displayName: "Fecha de la Emisión" },
      { field: 'share_type_identifier', displayName: "Tipo de Acción", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'initial_share', displayName: "Acción Inicial", cellFilter: 'number' },
      { field: 'final_share', displayName: "Acción Final", cellFilter: 'number' }
    ]
  }

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi

  $scope.doQuery = ->
    $scope.loading = true
    $http.post('/issuances/search.json', $scope.query)
      .success (data) ->
        $scope.loading = false
        $scope.gridOptions.data = data
      .error (data) ->
        $scope.loading = false

])