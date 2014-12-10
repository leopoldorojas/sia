# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid', 'ui.grid.selection'])
 
app.controller('SalesCtrl', ['$scope', '$http', 'uiGridConstants', 'dateFilter', ($scope, $http, uiGridConstants, dateFilter) ->
  termValue = dateFilter(new Date(), 'yyyy-MM')
  $scope.gridOptions = {
    enableFiltering: true,
    columnDefs: [
      { field: 'operation_date', displayName: "Fecha", filter: {term: termValue, condition: uiGridConstants.filter.CONTAINS} },
      { field: 'share_holder.name', displayName: "Socio" },
      { field: 'shares_assigned', displayName: "# de Acciones", cellFilter: 'number' },
      { field: 'share_type.identifier', displayName: "Tipo de Acción" },
      { field: 'cash', displayName: "Efectivo", cellFilter: 'number' },
      { field: 'dividends', displayName: "Dividendos", cellFilter: 'number' },
      { field: 'adjustment', displayName: "Ajustes", cellFilter: 'number'}
    ]
  }
  
  $http.get('/sales.json')
    .success (data) ->
      $scope.gridOptions.data = data
])
