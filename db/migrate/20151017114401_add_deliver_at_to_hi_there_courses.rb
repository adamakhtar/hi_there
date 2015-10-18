class AddDeliverAtToHiThereCourses < ActiveRecord::Migration
  def change
    add_column :hi_there_courses, :deliver_at, :time
  end
end
