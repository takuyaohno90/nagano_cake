class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_check_params)
    if params[:order][:select_button] == "1" then
      @order.post_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    byebug
      @order.save
    elsif params[:order][:select_button] == "2" then
      address = current_customer.addresses.find_by(id: params[:address_id])
    end
  end

  def finish
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def order_check_params
    params.require(:order).permit(:payment, :post_code, :shipping_address, :name)
  end

end
