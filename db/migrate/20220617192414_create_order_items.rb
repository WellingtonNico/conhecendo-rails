class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true, index: true, null: false
      t.references :book, foreign_key: true, index: true, null: false
      t.integer :quantity, null: false
      t.decimal :value, precision: 15, scale: 2, null: false

      t.timestamps
    end
  end
end
