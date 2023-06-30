class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum production_status: {wait: 0, stanby: 1, making: 2, finish: 3}
end
