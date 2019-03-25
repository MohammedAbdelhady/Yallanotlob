class ChangeMenuImageType < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :menu_image, :binary
  end
end
