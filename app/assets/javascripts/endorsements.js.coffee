# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid', 'ui.grid.selection'])
 
app.controller('endorsementsCtrl', ['$scope', '$http', 'uiGridConstants', 'dateFilter', '$window', ($scope, $http, uiGridConstants, dateFilter, $window) ->
  termValue = dateFilter(new Date(), 'yyyy-MM')
  $scope.loading = false
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'operation_date', displayName: "Fecha" },
      { field: 'source_share_holder.name', displayName: "Socio que endosa", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'share_holder.name', displayName: "Socio que recibe endoso", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'shares_assigned', displayName: "# de Acciones", cellFilter: 'number' },
      { field: 'receipt', displayName: "Memo", filter: {condition: uiGridConstants.filter.CONTAINS }}
    ]
  }

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi

  $scope.doQuery = ->
    $scope.loading = true
    $http.post('/endorsements/search.json', $scope.query)
      .success (data) ->
        $scope.loading = false
        $scope.gridOptions.data = data
      .error (data) ->
        $scope.loading = false

])