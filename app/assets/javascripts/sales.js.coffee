# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid', 'ui.grid.selection'])
 
app.controller('SalesCtrl', ['$scope', '$http', 'uiGridConstants', 'dateFilter', '$window', ($scope, $http, uiGridConstants, dateFilter, $window) ->
  termValue = dateFilter(new Date(), 'yyyy-MM')
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'operation_date', displayName: "Fecha" },
      { field: 'share_holder.name', displayName: "Socio", filter: {condition: uiGridConstants.filter.CONTAINS } },
      { field: 'shares_assigned', displayName: "# de Acciones", cellFilter: 'number' },
      { field: 'cash', displayName: "Efectivo", cellFilter: 'number', enableFiltering: false },
      { field: 'dividends', displayName: "Dividendos", cellFilter: 'number', enableFiltering: false },
      { field: 'adjustment', displayName: "Ajustes", cellFilter: 'number', enableFiltering: false},
      { field: 'receipt', displayName: "Recibo", filter: {condition: uiGridConstants.filter.CONTAINS }}
    ]
  }

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi
    gridApi.selection.on.rowSelectionChanged($scope, (row) ->
      $window.location.href="share_holders/" + row.entity.share_holder.id
    )

  $scope.doQuery = ->
    $http.post('/sales/search.json', $scope.query)
      .success (data) ->
        $scope.gridOptions.data = data

])
