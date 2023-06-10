class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|

      t.timestamps
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :buy_price, null: false
      t.integer :amount, null: false
      t.integer :production_status, null: false, default: 0
    end
  end
end
