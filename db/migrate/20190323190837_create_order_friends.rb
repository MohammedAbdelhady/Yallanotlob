class CreateOrderFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :order_friends do |t|
      t.references :user
      t.references :order
      t.string :user_status , :default => "invited" #or 'joined' when accept invitation
      #Ex:- :default =>''
      t.timestamps
    end
    add_index :order_friends, [:user_id,:order_id]
  end
end
