class Api::OrdersController < ApplicationController
  # POST /orders
  def create
    # get user_id from session
    @order = Order.create!(order_params)
    render json: @order, status: :created
  end

  private
    def order_params
      params.require(:order).permit(:status, :ebook_id, :user_id)
    end
end
