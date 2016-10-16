class AddRoomIdToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :room_id, :integer
  end
end
