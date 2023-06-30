class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    byebug
    order = Order.find(params[:id])
  end

  private

  def order_end
    params.require(:order).permit(:order_status, :production_status)
  end

end
