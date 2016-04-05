class SalesController < ActionController::API
  def index
    @sales = Sale.last(10).reverse
    @total = Sale.sum :amount

    respond_to do |format|
      format.html
      format.json {
        render json: {
            total: @total,
            sales: @sales.collect {|sale| {name: sale.name, amount: sale.amount}}
        }
      }
    end
  end
end
