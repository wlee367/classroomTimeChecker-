class AddTypeSToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :typeS, :string
  end
end
