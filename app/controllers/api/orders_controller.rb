class Api::OrdersController < ApplicationController
  # POST /orders
  def create
    # TODO: get user_id from session
    @order  = Orders::Create.call(order_params[:user_id], order_params[:ebook_id])
    render json: @order, status: :created
  end

  private
    def order_params
      params.require(:order).permit(:status, :ebook_id, :user_id)
    end
end
