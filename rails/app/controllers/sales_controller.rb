class SalesController < ApplicationController
  def index
    @sales = Sale.last(10).reverse
    @total = Sale.sum :amount
  end
end
