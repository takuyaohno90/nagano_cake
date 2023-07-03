class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    item = Item.all
    @count = 0
    item.each do |item|
      if item.is_active == true
        @count = @count + 1
      end
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
