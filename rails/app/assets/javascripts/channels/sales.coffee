#= require angular

App.sales = App.cable.subscriptions.create 'SalesChannel',
  connected: ->
    console.log '[WebSocket] connected - SalesChannel'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log '[WebSocket] disconnected - SalesChannel'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    ngScope = angular.element('[ng-controller]').scope()
    ngScope.$broadcast('newSale', data)

  sendDataToServer: (name, amount) ->
    console.log '[WebSocket] sending data to server'

    @perform 'clientMessage',
      name: name
      amount: amount
