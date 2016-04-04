App.sales = App.cable.subscriptions.create 'SalesChannel',
  connected: ->
    @perform 'register'

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    sales = document.getElementById 'sales'
    entry = document.createElement 'li'
    entry.className = 'bullet-item'
    entry.appendChild document.createTextNode(data['name'] + " - $" + data['amount'])
    sales.insertBefore(entry, sales.childNodes[4])
    total = document.getElementById 'total'
    document.getElementById('total').innerText = parseInt(total.innerText) + data['amount']

  broadcast: (data) ->
    @perform 'broadcast',
      name: document.getElementById('name').value
      amount: document.getElementById('amount').value

  register: ->
    @perform 'register'

$(document).on 'click', '[data-action=buy]', (event) ->
  App.sales.broadcast "test"
  event.target.value = ""
  event.preventDefault()
