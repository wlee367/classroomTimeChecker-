class RemoveRoomnumberFromRooms < ActiveRecord::Migration[5.0]
  def up
      remove_column :rooms, :roomnumber
  end

  def down
      add_column :rooms, :r_num, :string
  end
end
