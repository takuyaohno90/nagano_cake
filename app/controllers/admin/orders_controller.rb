class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_item = @order.order_items
    if params[:order][:order_status] == "check"
      @order_item.each do |order_item|
        order_item.update(production_status: "stanby")
      end
      @order.update(order_params)
      redirect_to admin_order_path(@order.id)
    end

  end

  private

  def order_params
    params.require(:order).permit(:order_status, :production_status)
  end

end
