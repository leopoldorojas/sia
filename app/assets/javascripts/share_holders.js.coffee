# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app')
 
app.controller('ShareHoldersCtrl', ['$scope', '$http', '$log', ($scope, $http, $log) ->
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'name', displayName: "Nombre" },
      { field: 'identifier', displayName: "Cédula" },
      { field: 'contact', displayName: "Contacto" },
      { field: 'phone', displayName: "Teléfono" },
      { field: 'email', displayName: "Email" },
      { field: 'location_id', displayName: "Ubicación", cellFilter: 'number' },
      { field: 'detail', displayName: "", cellTemplate: '<a ng-click="$event.stopPropagation(); deleteThisRow(row.entity);" href="#">Ver Detalle</a>', enableColumnMenu: false, enableFiltering: false }
    ]
  }
  
  $http.get('/share_holders.json')
    .success (data) ->
      $scope.gridOptions.data = data

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi
    gridApi.selection.on.rowSelectionChanged($scope, (row) ->
      msg = 'row selected ' + row.isSelected
      $log.log(msg)
    )

  $scope.deleteThisRow = (entity) ->
    console.log("holac")
    alert("hola")
])
