class AlterOrderTableSetDefault < ActiveRecord::Migration[5.2]
  def change

  change_column :orders, :order_status,:string ,:default => 'waiting' # to be finished
  #Ex:- :default =>''
  end
end
