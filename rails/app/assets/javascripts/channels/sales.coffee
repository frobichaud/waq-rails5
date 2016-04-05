App.sales = App.cable.subscriptions.create 'SalesChannel',
  connected: ->
    console.log '[WebSocket] connected - SalesChannel'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log '[WebSocket] disconnected - SalesChannel'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    sales = document.getElementById 'sales'
    entry = document.createElement 'li'
    entry.className = 'bullet-item'
    entry.appendChild document.createTextNode(data['name'] + " - $" + data['amount'])
    sales.insertBefore(entry, sales.childNodes[4])
    total = document.getElementById 'total'
    document.getElementById('total').innerText = parseInt(total.innerText) + data['amount']

  broadcast: ->
    console.log '[WebSocket] sending data to server'

    name = document.getElementById('name').value
    amount = document.getElementById('amount').value
    @perform 'broadcast',
      name: name
      amount: amount

$(document).on 'click', '[data-action=buy]', (event) ->
  App.sales.broadcast()
  event.preventDefault()
