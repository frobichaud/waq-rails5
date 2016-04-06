class SalesController < ActionController::API
  def index
    @sales = Sale.last(10).reverse
    @total = Sale.sum :amount

    render json: {
        total: @total,
        sales: @sales.collect {|sale| {name: sale.name, amount: sale.amount}}
    }
  end

  def create
    Sale.create! name: params['name'], amount: params['amount']
    render status: :created
  end
end
