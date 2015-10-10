class AddNameToHiThereCourses < ActiveRecord::Migration
  def change
    add_column :hi_there_courses, :name, :string
    add_index :hi_there_courses, :name
  end
end
