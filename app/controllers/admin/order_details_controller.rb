class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    completed = 0
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    order_id = @order_item.order_id
    order_items = OrderItem.where(order_id: order_id)
    order_items.each do |order_item|
      unless order_item.production_status == "finish"
        completed = true
        break
      end
    end

    unless completed == true
      @order_item.order.update(order_status: "standby")
    end

    if @order_item.production_status == "making"
      @order_item.order.update(order_status: "making")
    end
    redirect_to admin_order_path(@order_item.order_id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end
