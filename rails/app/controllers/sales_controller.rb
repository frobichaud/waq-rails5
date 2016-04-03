class SalesController < ApplicationController
  def index
    page = params[:page] || 1
    @sales = Sale.all#.paginate page: 1, pageSize: 25
  end
end
