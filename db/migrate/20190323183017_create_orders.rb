class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_type
      t.string :restaurant
      t.string :menu_image
      t.references :user, foreign_key: true
      t.string :order_status ,:default => 'waiting'
      #Ex:- :default =>''

      t.timestamps
    end
  end
end
