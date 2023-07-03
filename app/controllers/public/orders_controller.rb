class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_check_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    if params[:order][:select_button] == "1" then
      @order.post_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_button] == "2" then
      address = current_customer.addresses.find_by(id: params[:order][:address_id])
      @order.post_code = address.postal_code
      @order.shipping_address = address.address
      @order.name = address.name
    end
    @cart_items= current_customer.cart_items.all
    render 'check'
  end

  def create
    @order = Order.new(order_params)
    cart_items = current_customer.cart_items.all
    if @order.save
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.buy_price = cart_item.item.price
        order_item.amount = cart_item.amount
        order_item.save
      end
      cart_items.destroy_all
      redirect_to finish_orders_path
    else
      @order = Order.new(order_params)
      render :check

    end
  end

  def finish
  end


  def index
    @order = current_customer.orders.all
  end

  def show
    order_id = params[:id]
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: order_id)
  end

  private

  def order_check_params
    params.require(:order).permit(:payment, :post_code, :shipping_address, :name)
  end

  def order_params
    params.require(:order).permit(:customer_id, :payment, :post_code, :shipping_address, :name, :invoice, :postage)
  end

end
