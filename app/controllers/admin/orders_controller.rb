class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_item = @order.order_items
    if params[:order][:order_status] == "check"
      @order_item.each do |order_item|
        order_item.update(production_status: "stanby")
      end
    end
    redirect_to admin_order_path(@order.id)

  end

  private

  def order_params
    params.require(:order).permit(:order_status, :production_status)
  end

end
