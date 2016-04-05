#= require angular

app = angular.module('sales', [])
app.controller 'SalesController', ($http) ->
  $http.get('/sales/index')
