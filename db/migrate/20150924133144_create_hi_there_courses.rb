class CreateHiThereCourses < ActiveRecord::Migration
  def change
    create_table :hi_there_courses do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
