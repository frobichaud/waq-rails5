#= require angular

app = angular.module('sales', [])
app.controller 'SalesController', ($scope, $http, SalesService) ->
  $scope.service = SalesService

  $scope.refresh = ->
    # $http.get('http://private-5df9d-model3.apiary-mock.com/sales').then (response) ->
    $http.get('/sales').then (response) ->
      SalesService.sales = response.data.sales
      SalesService.total = response.data.total

  $scope.postSale = ->
    # $http.post('http://private-5df9d-model3.apiary-mock.com/sales', {name: $scope.name, amount: $scope.amount})
    $http.post('/sales', {name: $scope.name, amount: $scope.amount})

  $scope.refresh()

  $scope.$on 'newSale', (event, sale) ->
    console.log sale
    SalesService.sales.unshift sale
    SalesService.total += sale.amount
    $scope.$apply()

app.service 'SalesService', ->
  @total = 0
  @sales = []
