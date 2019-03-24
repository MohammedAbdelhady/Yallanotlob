class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :user
      t.string :item
      t.integer :amount
      t.integer :price
      t.text :comment  
      t.timestamps
    end
  end
end
