class CreateHiThereEmails < ActiveRecord::Migration
  def change
    create_table :hi_there_emails do |t|
      t.string :subject
      t.text :body
      t.integer :course_id, nil: false
      t.integer :interval, nil: false, default: 1

      t.timestamps null: false
    end
    add_index :hi_there_emails, :course_id
    add_index :hi_there_emails, :interval
  end
end
