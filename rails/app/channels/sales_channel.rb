# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SalesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'sales_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast(infos)
    Sale.create! name: infos['name'], amount: infos['amount'].gsub(/\D/,'').to_i
  end
end
