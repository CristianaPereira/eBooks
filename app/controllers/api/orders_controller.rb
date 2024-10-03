class Api::OrdersController < ApplicationController
  before_action :set_order, only: %i[ show ]

  # GET /orders/1
  def show
    render json: @order, status: :ok
  end

  # POST /orders
  def create
    @order  = Orders::Create.call(@current_user.id, order_params[:ebook_id])
    render json: @order, status: :created
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status, :ebook_id)
    end
end
