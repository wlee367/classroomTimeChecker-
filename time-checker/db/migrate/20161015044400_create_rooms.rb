class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :identifier
      t.integer :roomnumber
      t.string :building

      t.timestamps
    end
  end
end
