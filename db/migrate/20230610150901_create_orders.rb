class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
      t.integer :customer_id, null: false
      t.string :post_code, null: false
      t.string :shipping_address, null: false
      t.string :name, null: false
      t.integer :postage, null: false
      t.integer :invoice, null: false
      t.integer :payment, null: false, default: 0
      t.integer :order_status, null: false, default: 0

    end
  end
end
