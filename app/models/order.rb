class Order < ApplicationRecord
  enum payment_method: {credit_card: 0, transfer: 1}
  enum order_status: {stay: 0, check: 1, making: 2, standby: 3, finish: 4}
  belongs_to :customer
  has_many :order_items

  validates :customer_id, presence: true
  validates :post_code, presence: true
  validates :shipping_address, presence: true
  validates :name, presence: true
  validates :postage, presence: true
  validates :invoice, presence: true
  validates :payment, presence: true
  validates :order_status, presence: true

  def confirm_one
  end

  def confirm_two
  end

  def address_display
    '〒' + post_code + '' + shipping_address + '' + name
  end
end
