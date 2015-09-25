class AddWorkflowStateToHiThereCourses < ActiveRecord::Migration
  def change
    add_column :hi_there_courses, :workflow_state, :string
    add_index :hi_there_courses, :workflow_state
  end
end
