# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app', ['ui.grid'])
 
app.controller('MainCtrl', ['$scope', ($scope) ->

  $scope.gridOptions1 = {
    enableSorting: true,
    columnDefs: [
      { field: 'firstName' },
      { field: 'lastName' },
      { field: 'company', enableSorting: false },
      { field: 'employed'}
    ]
  }
 
  $scope.gridOptions1.data = [
    {
        "firstName": "Cox",
        "lastName": "Carney",
        "company": "Enormo",
        "employed": true
    },
    {
        "firstName": "Lorraine",
        "lastName": "Wise",
        "company": "Comveyer",
        "employed": false
    },
    {
        "firstName": "Nancy",
        "lastName": "Waters",
        "company": "Fuelton",
        "employed": false
    }
  ]
])