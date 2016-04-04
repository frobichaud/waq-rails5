class Sale < ApplicationRecord
  after_commit :publish, on: :create

  validates_presence_of :name
  validates_presence_of :amount

  def publish
    #ActionCable.server.broadcast 'sales_channel', {name: self.name, amount: self.amount}
    SalesWorker.perform_async self.id
  end
end
