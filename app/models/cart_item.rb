class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :item_id, presence: true
  validates :customer_id, presence: true
  validates :amount, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end
end
