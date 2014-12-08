# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app')
 
app.controller('ShareHoldersCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.gridOptions = {
    enableFiltering: true,
    columnDefs: [
      { field: 'name', displayName: "Nombre" },
      { field: 'identifier', displayName: "Cédula" },
      { field: 'contact', displayName: "Contacto" },
      { field: 'phone', displayName: "Teléfono" },
      { field: 'email', displayName: "Email" },
      { field: 'location_id', displayName: "Ubicación", cellFilter: 'number' },
      { field: 'detail', cellTemplate: '<a href="leo">Ver Detalle</a>' }
    ]
  }
  
  $http.get('/share_holders.json')
    .success (data) ->
      $scope.gridOptions.data = data
])
