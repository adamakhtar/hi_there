class CreateHiThereSubscriptions < ActiveRecord::Migration
  def change
    create_table :hi_there_subscriptions do |t|
      t.string :email
      t.string :workflow_state
      t.integer :course_id

      t.timestamps null: false
    end
    add_index :hi_there_subscriptions, :email
    add_index :hi_there_subscriptions, :course_id
    add_index :hi_there_subscriptions, :workflow_state
  end
end
