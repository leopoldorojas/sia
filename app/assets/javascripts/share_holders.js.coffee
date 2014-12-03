# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid'])
 
app.controller('ShareHoldersCtrl', ['$scope', '$http', 'uiGridConstants', 'dateFilter', ($scope, $http, uiGridConstants, dateFilter) ->
  $scope.gridOptions = {
    enableFiltering: true,
    columnDefs: [
      { field: 'name', displayName: "Nombre" },
      { field: 'identifier', displayName: "Cédula" },
      { field: 'contact', displayName: "Contacto o Representante" },
      { field: 'phone', displayName: "Teléfono" },
      { field: 'email', displayName: "Correo Electrónic" },
      { field: 'location_id', displayName: "Código de Localización", cellFilter: 'number' }
    ]
  }
  
  $http.get('/share_holders.json')
    .success (data) ->
      $scope.gridOptions.data = data
])
