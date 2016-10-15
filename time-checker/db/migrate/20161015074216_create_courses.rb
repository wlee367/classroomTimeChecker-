class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :type
      t.string :code
      t.string :start
      t.string :end
      t.string :location

      t.timestamps
    end
  end
end
