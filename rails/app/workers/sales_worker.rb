class SalesWorker
  include Sidekiq::Worker

  def perform(sale_id)
    sale = Sale.find sale_id
    ActionCable.server.broadcast 'sales_channel', {name: sale.name, amount: sale.amount}
  end
end
