class AddRNumToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :r_num, :string
  end
end
