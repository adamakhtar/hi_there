class AddDescriptionToHiThereCourses < ActiveRecord::Migration
  def change
    add_column :hi_there_courses, :description, :text
  end
end
