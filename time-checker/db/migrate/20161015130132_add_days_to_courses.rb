class AddDaysToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :days, :string
  end
end
