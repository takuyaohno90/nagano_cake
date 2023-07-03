class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item_check = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if !@cart_item_check
        @cart_item.customer_id = current_customer.id
        @cart_item.save
        redirect_to cart_items_path
    else
      new_amount = @cart_item.amount.to_i + @cart_item_check.amount.to_i
      @cart_item_check.amount = new_amount
      @cart_item_check.save
      redirect_to cart_items_path
    end

  end

  def update
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
