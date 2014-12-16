# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app')
 
app.controller('ShareHoldersCtrl', ['$scope', '$http', '$window', ($scope, $http, $window) ->
  $scope.gridOptions = {
    enableFiltering: true,
    enableRowHeaderSelection: false,
    multiSelect: false,
    columnDefs: [
      { field: 'name', displayName: "Nombre" },
      { field: 'identifier', displayName: "Cédula" },
      { field: 'contact', displayName: "Contacto" },
      { field: 'equity', displayName: "Capital Invertido", cellFilter: 'number'  },
      { field: 'earnings', displayName: "Utilidad", cellFilter: 'number'  },
      { field: 'stock_prepaid', displayName: "Adelanto", cellFilter: 'number' }
    ]
  }
  
  $http.get('/share_holders.json')
    .success (data) ->
      $scope.gridOptions.data = data

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi
    gridApi.selection.on.rowSelectionChanged($scope, (row) ->
      $window.location.href="share_holders/" + row.entity.id
    )
])
