class Sale < ApplicationRecord
  after_commit :publish

  def publish
    SalesWorker.perform_async self.id
  end
end
